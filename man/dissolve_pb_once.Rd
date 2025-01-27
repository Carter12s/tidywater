% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dissolve_pb.R
\name{dissolve_pb_once}
\alias{dissolve_pb_once}
\title{Apply `dissolve_pb` to a dataframe and create a new column with numeric dose}
\usage{
dissolve_pb_once(
  df,
  input_water = "defined_water",
  output_col_solid = "controlling_solid",
  output_col_result = "pb",
  hydroxypyromorphite = "Schock",
  pyromorphite = "Topolska",
  laurionite = "Nasanen",
  water_prefix = TRUE
)
}
\arguments{
\item{df}{a data frame containing a water class column, which has already been computed using
\code{\link{define_water_chain}}}

\item{input_water}{name of the column of water class data to be used as the input. Default is "defined_water".}

\item{output_col_solid}{name of the output column storing the controlling lead solid. Default is "controlling_solid".}

\item{output_col_result}{name of the output column storing dissolved lead in M. Default is "pb".}

\item{hydroxypyromorphite}{defaults to "Schock", the constant, K, developed by Schock et al (1996). Can also use "Zhu".}

\item{pyromorphite}{defaults to "Topolska", the constant, K, developed by Topolska et al (2016). Can also use "Xie".}

\item{laurionite}{defaults to "Nasanen", the constant, K, developed by Nasanen & Lindell (1976). Can also use "Lothenbach".}

\item{water_prefix}{name of the input water used for the calculation, appended to the start of output columns. Default is TRUE.
Chenge to FALSE to remove the water prefix from output column names.}
}
\value{
A data frame containing the controlling lead solid and modeled dissolved lead concentration as new columns.
}
\description{
This function allows \code{\link{dissolve_pb}} to be added to a piped data frame.
Two additional columns will be added to the dataframe; the name of the controlling lead solid, and total dissolved lead (M).
}
\details{
The data input comes from a `water` class column, initialized in \code{\link{define_water}} or \code{\link{balance_ions}}.
Use the `output_col_solid` and `output_col_result` arguments to name the ouput columns for the controlling lead solid
and total dissolved lead, respectively. The input `water` used for the calculation will be appended to the
start of these output columns. Omit the input `water` in the output columns, set `water_prefix` to FALSE (default is TRUE).

 For large datasets, using `fn_once` or `fn_chain` may take many minutes to run. These types of functions use the furrr package
 for the option to use parallel processing and speed things up. To initialize parallel processing, use
 `plan(multisession)` or `plan(multicore)` (depending on your operating system) prior to your piped code with the
 `fn_once` or `fn_chain` functions. Note, parallel processing is best used when your code block takes more than a minute to run,
 shorter run times will not benefit from parallel processing.
}
\examples{

library(purrr)
library(furrr)
library(tidyr)
library(dplyr)

example_df <- water_df \%>\%
  define_water_chain() \%>\%
  balance_ions_chain() \%>\%
  dissolve_pb_once(input_water = "balanced_water")

example_df <- water_df \%>\%
  define_water_chain() \%>\%
  dissolve_pb_once(output_col_result = "dissolved_lead", pyromorphite = "Xie")

# Initialize parallel processing
plan(multisession)
example_df <- water_df \%>\%
  define_water_chain() \%>\%
  dissolve_pb_once(output_col_result = "dissolved_lead", laurionite = "Lothenbach")

# Optional: explicitly close multisession processing
plan(sequential)

}
\seealso{
\code{\link{dissolve_pb}}
}
