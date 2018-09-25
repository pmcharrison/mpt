.onLoad <- function(libname, pkgname) {
  packageStartupMessage(
    "Note: on September 25th 2018, the following change was made to ",
    "default arguments for mpt(), demo_mpt(), and standalone_mpt():\n",
    "- next_item.estimator now defaults to 'BM', not 'WL'.\n"
  )
}
