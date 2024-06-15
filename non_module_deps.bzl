# Load nixpkgs_git_repository from rules_nixpkgs,
# which was already initialized by rules_haskell_dependencies above.
load("@rules_nixpkgs_cc//:cc.bzl", "nixpkgs_cc_configure")
load(
    "@rules_nixpkgs_core//:nixpkgs.bzl",
    "nixpkgs_git_repository",
    "nixpkgs_package",
)
load("@rules_nixpkgs_python//:python.bzl", "nixpkgs_python_configure")
def _non_module_deps_impl(_mctx):
    # Fetch a version of nixpkgs from GitHub.
    # For more information see the documentation of rules_nixpkgs at
    # https://github.com/tweag/rules_nixpkgs/blob/master/README.md
    nixpkgs_git_repository(
        name = "nixpkgs",
        revision = "nixos-23.11",
    )
    nixpkgs_cc_configure(
        name = "local_config_cc",
        repository = "@nixpkgs",
        register = False,
    )
    nixpkgs_python_configure(
        name = "nixpkgs_python_toolchain",
        repository = "@nixpkgs",
        register = False,
    )
    # For zlib.BUILD.bazel
    nixpkgs_package(
        name = "nixpkgs_zlib",
        attribute_path = "zlib",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "zlib.dev",
        build_file = "//:zlib.BUILD.bazel",
        repository = "@nixpkgs",
    )
non_module_deps = module_extension(implementation = _non_module_deps_impl)
