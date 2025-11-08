rmarkdown::render(
  input        = "docs/index.md",
  output_dir   = tempdir(),          # carpeta temporal segura
  output_file  = "index.html"
)
file.copy(file.path(tempdir(), "index.html"), "docs/index.html", overwrite = TRUE)

