library(shiny)
library(ggvis)
#library(shinyWidgets) #only if we wanted a background image

fluidPage(
  #setBackgroundImage(width="400" ,height="300",src ="https://cdn.eslgaming.com/misc/media/play/fifa/news/fifa19newsbanner.png"),
  fluidRow(
    column(1,
           tags$img(width="930" ,height="270",
                    src ="https://compass-ssl.xbox.com/assets/46/58/465889e7-3a93-47b6-8323-087f23eb1132.jpg?n=FIFA-19_GLP-Page-Hero-1084_1920x600_02.jpg")
           )
  ),
  fluidRow(
    column(3,
          wellPanel(
             h3("Player Filter")
             )
    )
  ),
  fluidRow(
    column(3,
           wellPanel(
             sliderInput("rating", "Overall rating",40, 99, value = c(90, 95)),
             sliderInput("pace", "Pace", 0, 99, value = c(10, 99)),
             sliderInput("shot", "Shot", 0, 99, value = c(10,99)),
             sliderInput("pass", "Pass", 0, 99, value = c(10, 99)),
             sliderInput("drible", "Drible", 0, 99, value = c(10, 99)),
             sliderInput("defense", "Defense", 0, 99, value = c(10, 99)),
             sliderInput("physic", "Physicallity",0, 99, c(10, 99)), 
             checkboxInput("extra", "Extra Information"),
             conditionalPanel(
               condition = "input.extra == true",
               selectInput("pos", "Position of the player",
                           c("All",
                             "ST", "CF", #attackers
                             "CAM", "CM", "CDM", #midfielders
                             "LF", "LW", "LM", "RF", "RW", "RM",#lateral midfielders
                             "LB", "LWB", "RB", "RWB", "CB", #defenders
                             "GK") #goalkeeper
               ),
               selectInput("nation", "Nationality of the player (Ordered by #Players)",
                           c("All",
                             "Spain", "France", "Brazil", "Germany", "Argentina", "Italy", "England",
                             "Portugal","Holland", "Belgium", "Uruguay", "Colombia", "Croatia", "Serbia", "Switzerland", 
                             "Mexico", "Turkey", "Denmark", "Russia", "Senegal", "Austria","Ukraine", "Morocco",
                             "Poland", "Czech Republic", "Chile", "Algeria", "Sweden", "Greece", "Nigeria", "Ghana",
                             "Japan", "Bosnia and Herzegovina", "Norway", "United States", "Wales", "Cameroon", "Slovakia",
                             "Slovenia", "Egypt", "Romania", "Paraguay", "Australia", "Korea Republic", "Venezuela", "Peru",
                             "Venezuela", "Gabon", "Ecuador", "Guinea-Bissau", "Costa Rica", "Finland", "Montenegro", "Albania",
                             "Kosovo", "Hungary", "Canada", "Iceland", "Northern Ireland", "Mali","Togo",
                             "Bulgaria", "Israel", "Dominican Republic", "Tunisia", "South Africa", "Syria", "Georgia") 
               ),
               selectInput("league", "League of the player (Ordered by #Players)",
                           c("All",
                             "Premier League","LaLiga Santander","Serie A TIM", "Bundesliga", 
                             "Ligue 1 Conforama", "Liga NOS", "Süper Lig", "Eredivisie",
                             "Major League Soccer","LIGA Bancomer MX","League of Russia",
                             "EFL Championship", "Belgium Pro League",  "Ukrayina Liha",
                             "Saudi Professional League","LaLiga 1 I 2 I 3","Bundesliga 2",
                             "EFL League Two", "Calcio B","Domino’s Ligue 2",
                             "Meiji Yasuda J1 League","Hellas Liga","SAF", "Raiffeisen Super League",
                             "Scottish Premiership","Liga Dimayor", "Česká Liga", "Campeonato Scotiabank",
                             "South African FL", "Allsvenskan", "Hyundai A-League")
               )
             )
           )),
    column(9,
           wellPanel(
             fluidRow(
               h3("Scatter Plot of the filtered players: ")
             ),
             
             fluidRow(
               tabsetPanel(
                 tabPanel("Plot",ggvisOutput("plot1")),
                 tabPanel("Data", dataTableOutput("data1")
)
          )
        )
  )
)
)
)


  
