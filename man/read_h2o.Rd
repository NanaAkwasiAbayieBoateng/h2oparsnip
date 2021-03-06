% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_h2o.R
\name{read_h2o}
\alias{read_h2o}
\title{Reads an H2O model from file and inserts it back into a previously fitted
parsnip model specification or workflow object}
\usage{
read_h2o(object, filename, ...)
}
\arguments{
\item{object}{Either a `workflows::workflow()` object contained a fitted
model when using the workflows package, or a `model_spec` object from a
fitted model when using the parsnip package directly.}

\item{filename}{A `character` specifying the file path used to read the
model.}
}
\value{
The parsnip `model_spec` object or workflows `workflow` object with
  the H2O model inserted back into the model object.
}
\description{
H2O models cannot be saved using the typical R approaches such as saveRDS
because the actual H2O model is contained within a Java virtual machine. H2O
models need to be saved and restored using the `h2o::h2o.saveModel` and
`h2o::h2o.loadModel` functions. This is inconvenient for using H2O models
contained within parsnip model specifications or workflow objects.
}
\details{
The `write_h2o` function extracts the H2O model from within a parsnip or
workflow fitted model and saves it to file using the `h2o::h2o.saveModel`
function. To restore a model and insert it back into a previously fitted
model use the `read_h2o` function.
}
\examples{
library(parsnip)
library(h2o)

# start a h2o session
h2o.init()

# fit a parsnip model using the h2o engine
clf <- mlp(mode = "classification") \%>\%
    set_engine("h2o")

model_fit <- clf \%>\% fit(Species ~., iris)

# save the parsnip model
saveRDS(model_fit, file.path(tempdir(), "my_model.rds"))

# save the h2o component of the model
write_h2o(object = model_fit, filename = file.path(tempdir(), "my_h2o_model.mod"))
h2o.shutdown(prompt = FALSE)

# restore a model
h2o.init()
model_fit <- readRDS(file.path(tempdir(), "my_model.rds"))

# read and insert the H2O model back into the parsnip object
model_fit <- read_h2o(model_fit, file.path(tempdir(), "my_h2o_model.mod"))
}
