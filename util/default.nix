{ lib, ... }:

rec {
  mapAttrNames = f:
    lib.mapAttrs' (name: value: lib.nameValuePair (f name) value);

  readVisible = path:
    lib.filterAttrs (name: value: !(lib.hasPrefix "." name))
    (builtins.readDir path);

  filterFileType = type: dir:
    lib.attrNames (lib.filterAttrs (name: type': type == type') dir);

  filterRegularFiles = filterFileType "regular";

  filterDirectories = filterFileType "directory";

  readVisibleDirectories = path: filterDirectories (readVisible path);

  secretDir = prefix: path:
    let
      prefixStr = if prefix != null then "${prefix}." else "";
      dir = readVisible path;
      dirs = builtins.map (name:
        mapAttrNames (name': "${name}/${name'}")
        (secretDir null (path + "/${name}"))) (filterDirectories dir);
      files = filterRegularFiles dir;
    in builtins.listToAttrs (builtins.map (name:
      lib.nameValuePair "${prefixStr}${name}" {
        sopsFile = path + "/${name}";
        format = "binary";
      }) files) // lib.foldr (x: y: x // y) { } dirs;

  genNixosConfigs = { deploy-rs, path, sharedModules ? [ ], extraArgs ? { }
    , deployOptions ? { } }:
    let
      systems = readVisibleDirectories path;
      hosts = lib.concatMap (system:
        builtins.map (host: { inherit host system; })
        (readVisibleDirectories (path + "/${system}"))) systems;
      hostModule = host: [{
        networking = {
          hostName = host;
          hostId = builtins.substring 0 8 (builtins.hashString "sha256" host);
        };
      }];
      buildConfig = { system, host }:
        lib.nameValuePair host (lib.nixosSystem {
          inherit system extraArgs;
          modules = lib.flatten [
            [ (path + "/${system}/${host}") ]
            (hostModule host)
            sharedModules
          ];
        });
      nixosConfigurations = lib.listToAttrs (builtins.map buildConfig hosts);
      buildDeployment = { host, ... }:
        lib.nameValuePair host {
          hostname = host;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              nixosConfigurations."${host}";
          };
        };
      deploy = {
        nodes = lib.listToAttrs (builtins.map buildDeployment hosts);
      } // deployOptions;
    in { inherit nixosConfigurations deploy; };

  genHomeConfig =
    { buildConfig, defaultNixpkgs, defaultOverlays ? [ ], sharedModules ? [ ] }:
    { allowUnfree ? false, extraModules ? [ ], homeDirectory, overlays ? [ ]
    , pkgs ? defaultNixpkgs."${system}", profiles, system, username }:
    buildConfig {
      inherit homeDirectory pkgs system username;
      configuration = { ... }: {
        inherit profiles;
        nixpkgs = {
          config = { inherit allowUnfree; };
          overlays = defaultOverlays ++ overlays;
        };
        imports = sharedModules ++ extraModules;
      };
    };
}
