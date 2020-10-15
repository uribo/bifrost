#' Insert jupytext configuration to R Markdown
#' @param path path to R Markdown file
#' @export
add_jupytext <- function(path) {
  xx <- xfun::read_utf8(path)
  end_yml_header <- grep("---", xx)[2]
  line_end_n <-
    if(end_yml_header == length(xx)) {
    NULL
  } else {
    seq.int(end_yml_header + 1,
            length(xx))
  }
  contents <-
    paste0(
      paste0(xx[seq.int(end_yml_header - 1)],
             collapse = "\n"),
      sprintf('
jupyter:
  jupytext:
    formats: ipynb,Rmd
    text_representation:
      extension: .Rmd
      format_name: rmarkdown
      format_version: "1.1"
      jupytext_version: 1.2.4
  kernelspec:
    display_name: R
    language: R
    name: ir\n---\n'),
paste0(xx[line_end_n],
       collapse = "\n"))
  con <- file(path, open = "w", encoding = "UTF-8")
  on.exit(close(con), add = TRUE)
  xfun::write_utf8(contents, con)
}

jupytext_sync <- function(path) {
  if (is_installed_jupytext()) {
    processx::run(path_to_jupytext(),
                  #args = unlist(args),
                  args = c("--sync", path),
                  echo = TRUE,
                  echo_cmd = TRUE)
  }
}

jupytext_run <- function(path) {
  processx::run(paste(dirname(reticulate::py_config()$python_versions[1]),
                      "jupyter",
                      sep = "/"),
                args = c("nbconvert",
                         "--to",
                         "notebook",
                         "--inplace",
                         "--execute",
                         path))
}

