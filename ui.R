library(shiny)



shinyUI(fluidPage(
  # Application title
  h4("Cost-efficient designs for three-arm trials with treatment delivered by health professionals: sample sizes for a combination of nested and crossed designs."),

  hr(),
  fluidRow(
    column(2,
           h4("Type I error rate and power"),
           numericInput("alpha", label = h6("Type I error rate (alpha)"), value = 0.05,min=0,max=1,step=0.05),
           numericInput("power", label = h6("Power level (1-beta)"), value = 0.8,min=0,max=1,step=0.05)
    ),
    column(2, 
           h4("Means"),
           numericInput("mT", label = h6("Mean outcome cognitive therapy"), value = 5.5,min=0),
           numericInput("mM", label = h6("Mean outcome medication"), value = 7.95,min=0),
           numericInput("mP", label = h6("Mean outcome placebo"), value = 9.5,min=0)
    ),
    column(2, 
           h4("Variances and intraclass correlation coefficients"),
           numericInput("vartotT", label = h6("Total outcome variance cognitive therapy"), value = 5.93^2,min=0),
           numericInput("vartotM", label = h6("Total outcome variance medication"), value = 7.2^2,min=0),
           numericInput("vartotP", label = h6("Total outcome variance placebo"), value = 7.32^2,min=0),
           numericInput("ICCT", label = h6("ICC cognitive therapy"), value = 0.05,min=0,max=1,step=0.01),
           numericInput("ICCM", label = h6("ICC medication"), value = 0.1,min=0,max=1,step=0.01),
           numericInput("ICCP", label = h6("ICC placebo"), value = 0.1,min=0,max=1,step=0.01),
           numericInput("varMP", label = h6("Variance of random effect medication vs placebo"), value = 0.05,min=0,max=1,step=0.01)
    ),
    column(2,
           h4("Cost specification"),
           numericInput("c2T", label = h6("Costs per psychologist"), value = 1000,min=0),
           numericInput("c2MP", label = h6("Costs per psychiatrist"), value = 250,min=0),
           numericInput("c1T", label = h6("Costs per patient in cognitive therapy"), value = 200,min=0),
           numericInput("c1M", label = h6("Costs per patient in medication"), value = 200,min=0),
           numericInput("c1P", label = h6("Costs per patient in placebo"), value = 20,min=0)
    ),
    column(2,
           h4("Sample size ranges"),
           sliderInput("kT",h6("Number of psychologists:"),min = 1,max = 30, value = c(1,30)),
           sliderInput("kMP",h6("Number of psychiatrists:"),min = 1,max = 30, value = c(1,30)),
           sliderInput("nT",h6("Number of patients per psychologist:"),min = 1,max = 30, value = c(15,15)),
           sliderInput("nMP",h6("Total number of patients per psychiatrist:"),min = 1,max = 30, value = c(25,25)),
           h6("Use the sliders above to select the sample size ranges that are feasible for the trial at hand, or to fix one or more of the sample sizes to a fixed value.")
    ),

    hr(),
    selectInput("minimize", label = h4("Minimization of:"), 
                choices = list("Costs" = 1, "Total number of patients" = 2), 
                selected = 1),

    h4("Optimal design(s):"),
    tableOutput("table1"),
    h6("If the output table is displayed in grey: calculations are in progress."),
    h6("If the output table contains the entry 'NA' only: there is no design for which the type I error rate and power level are as specified.")
  )
))