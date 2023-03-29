# Mistuning Perception Test (MPT)

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1415363.svg)](https://doi.org/10.5281/zenodo.1415363)
[![R-CMD-check](https://github.com/pmcharrison/mpt/workflows/R-CMD-check/badge.svg)](https://github.com/pmcharrison/mpt/actions)

The MPT is an adaptive test of mistuning perception abilities.

We invite you to try the MPT [here!](http://shiny.pmcharrison.com/mpt-demo)

## Citation

The MPT is introduced in the following paper:

> Larrouy-Maestri, P., Harrison, P. M. C., & Müllensiefen, D. (2019). The mistuning perception test: A new measurement instrument. Behavior Research Methods, 51(2), 663–675. https://doi.org/10.3758/s13428-019-01225-1

You can also cite this specific implementation here:

> Larrouy-Maestri, P., Harrison, P. M. C., & Müllensiefen, D. (2018).
Mistuning Perception Test, psychTestR implementation. Zenodo.
https://doi.org/10.5281/zenodo.1415363

We also advise mentioning the software versions you used,
in particular the versions of the `mpt`, `psychTestR`, and `psychTestRCAT` packages.
You can find these version numbers from R by running the following commands:

``` r
library(mpt)
library(psychTestR)
library(psychTestRCAT)
if (!require(devtools)) install.packages("devtools")
x <- devtools::session_info()
x$packages[x$packages$package %in% c("mpt", "psychTestR", "psychTestRCAT"), ]
```

## Acknowledgements

We are grateful to the following individuals for translating the MPT
into new languages:

- Pauline Larrouy-Maestri (French)
- Dania Hollemann, Klaus Frieler, Daniel Müllensiefen (German, formal German)
- Elina Tsigeman and Maxim Likhanov (Russian)
- Cecilie Møller and Niels Christian-Hansen (Danish)
- Jochum van 't Hooft (Dutch)
- Elvira Brattico (Italian)

## Installation instructions (local use)

1. If you don't have R installed, install it from here: https://cloud.r-project.org/

2. Open R.

3. Install the ‘devtools’ package with the following command:

`install.packages('devtools')`

4. Install the MPT:

`devtools::install_github('pmcharrison/mpt')`

## Usage

### Quick demo 

You can demo the MPT at the R console, as follows:

``` r
# Load the mpt package
library(mpt)

# Run a demo test, with feedback as you progress through the test,
# and not saving your data
demo_mpt()

# Run a demo test, skipping the training phase, and only asking 5 questions
demo_mpt(num_items = 5, take_training = FALSE)
```

### Testing a participant

The `standalone_mpt()` function is designed for real data collection.
In particular, the participant doesn't receive feedback during this version.

``` r
# Load the mpt package
library(mpt)

# Run the test as if for a participant, using default settings,
# saving data, and with a custom admin password
standalone_mpt(admin_password = "put-your-password-here")
```

You will need to enter a participant ID for each participant.
This will be stored along with their results.

Each time you test a new participant,
rerun the `standalone_mpt()` function,
and a new participation session will begin.

You can retrieve your data by starting up a participation session,
entering the admin panel using your admin password,
and downloading your data.
For more details on the psychTestR interface, 
see http://psychtestr.com/.

The MPT currently supports English (EN), French (FR), German (DE),
formal German (DE_F), Russian (RU), Danish (DA), Spanish (ES), Latvian (LV), and Italian (IT).
If you are interested in adding a new language, contact us and we can add it for you.
You can select one of these languages by passing a language code as 
an argument to `standalone_mpt()`, e.g. `standalone_mpt(languages = "DE")`,
or alternatively by passing it as a URL parameter to the test browser,
eg. http://127.0.0.1:4412/?language=DE (note that the `p_id` argument must be empty).
Please note that the demo version of the test (`demo_mpt`) only supports English.

### Results

The main output from the MPT is an `ability` score,
corresponding to the ability estimate for the participant.
It is computed from the underlying item response model and ranges approximately from -4 to +4.
A secondary output is an `ability_sem` score, 
corresponding to the standard error of measurement for the ability estimate;
again, it is computed from the underlying IRT model.
For most applications you would only use the `ability` value,
unless using a statistical analysis technique that allows you to specify measurement error explicitly.
For more information about item response theory, see the [Wikipedia](https://en.wikipedia.org/wiki/Item_response_theory) article;
for more information about MPT scores, see
[Larrouy-Maestri et al. (2019)](https://doi.org/10.3758/s13428-019-01225-1).

psychTestR provides several ways of retrieving test results (see http://psychtestr.com/).
Most are accessed through the test's admin panel.

* If you are just interested in the participants' final scores,
the easiest solution is usually to download the results in CSV format from the admin panel.
* If you are interested in trial-by-trial results, you can run the command
`compile_trial_by_trial_results()` from the R console
(having loaded the MPT package using `library(mpt)`).
Type `?compile_trial_by_trial_results()` for more details.
* If you want still more detail, you can examine the individual RDS output files using `readRDS()`. 
Detailed results are stored as the 'metadata' attribute for the ability field. 
You can access it something like this: 

``` r
x <- readRDS("output/results/your-output-file.rds")
attr(x$MPT$ability, "metadata")
```

## Installation instructions (Shiny Server)

1. Complete the installation instructions described under 'Local use'.
2. If not already installed, install Shiny Server Open Source:
https://www.rstudio.com/products/shiny/download-server/
3. Navigate to the Shiny Server app directory.

`cd /srv/shiny-server`

4. Make a folder to contain your new Shiny app.
The name of this folder will correspond to the URL.

`sudo mkdir mpt`

5. Make a text file in this folder called `app.R`
specifying the R code to run the app.

- To open the text editor: `sudo nano mpt/app.R`
- Write the following in the text file:

``` r
library(mpt)
standalone_mpt(admin_password = "put-your-password-here")
```

- Save the file (CTRL-O).

6. Change the permissions of your app directory so that `psychTestR`
can write its temporary files there.

`sudo chown -R shiny mpt`

where `shiny` is the username for the Shiny process user
(this is the usual default).

7. Navigate to your new shiny app, with a URL that looks like this:
`http://my-web-page.org:3838/mpt

## Implementation notes

By default, the MPT implementation always estimates participant abilities
using weighted-likelihood estimation.
This differs from our validation study, 
where online abilities were scored using Bayes modal estimation.
We adopt weighted-likelihood estimation for this release 
because this technique makes fewer assumptions about the participant group being tested.
This makes the test better suited to testing with diverse participant groups
(e.g. children, clinical populations).

## Usage notes

- The MPT runs in your web browser.
- By default, audio files are hosted online on our servers.
The test therefore requires internet connectivity.

## Adding new languages

See `data-raw/dict-russian.csv` for an example of a foreign-language dictionary.
Create a new dictionary for your new language following this format.
Prepare a merge request for submitting your changes, 
perhaps using a fork of the original repository.
Place the file in `data-raw`.
Update `data-raw/mpt-dict.R`, adding a new four-line section for your new language,
following the lines used to add previous languages.
Run the file and commit the changes to Git.
Update the languages section in `README.md` to credit the translator.
Rebuild the R package locally and test that you can use the test with
your new translations.
Submit your changes as a merge request.
