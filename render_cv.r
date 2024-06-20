
options(gargle_oauth_email = TRUE)

# datadrivencv::use_datadriven_cv(full_name = "Darren Churchward",
#                                 data_location = "https://docs.google.com/spreadsheets/d/1vULaA1GDD6L3Lq6BbGAxXeYUPhiEg-ew-PZY8VEp0UI/edit?usp=sharing")


googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1vULaA1GDD6L3Lq6BbGAxXeYUPhiEg-ew-PZY8VEp0UI/edit?usp=sharing",
                          sheet = "language_skills",
                          skip = 1)


googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1vULaA1GDD6L3Lq6BbGAxXeYUPhiEg-ew-PZY8VEp0UI/edit?usp=sharing",
                          sheet = "entries",
                          skip = 1)


googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1vULaA1GDD6L3Lq6BbGAxXeYUPhiEg-ew-PZY8VEp0UI/edit?usp=sharing",
                          sheet = "text_blocks",
                          skip = 1)


googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1vULaA1GDD6L3Lq6BbGAxXeYUPhiEg-ew-PZY8VEp0UI/edit?usp=sharing",
                          sheet = "contact_info",
                          skip = 1)


# This script builds both the HTML and PDF versions of your CV

# If you wanted to speed up rendering for googlesheets driven CVs you could use
# this script to cache a version of the CV_Printer class with data already
# loaded and load the cached version in the .Rmd instead of re-fetching it twice
# for the HTML and PDF rendering. This exercise is left to the reader.

# Knit the HTML version
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = FALSE),
                  output_file = "darren-churchward_cv.html")

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = TRUE),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "darren-churchward_cv.pdf")
