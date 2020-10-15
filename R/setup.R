check_dependencies_available <- function() {
  list(IRkernel = is_installed_pkg("IRkernel"),
       JuliaCall = is_installed_pkg("JuliaCall"))
}

is_installed_pkg <- function(pkg) {
  sum(grepl(paste0("^",
                   pkg,
                   "$"),
            utils::installed.packages())) > 0
}

path_to_jupytext <- function() {
  paste(
    "/Users/uri/miniconda3/envs/r-reticulate/",
    #reticulate::miniconda_path(),
    "bin",
    "jupytext",
    sep = "/")
}

is_installed_jupytext <- function() {
  file.exists(path_to_jupytext())
}
