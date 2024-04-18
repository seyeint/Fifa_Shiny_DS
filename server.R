library(ggvis)
library(dplyr)
library(ggplot2)
library(DT)
# The goods
filename <- "~/z_Data_Viz/project/Fifa19.csv" # change directory

# Read the CSV
db <- read.csv(filename, header = TRUE, sep = ",")
function(input, output, session) {
  
  dataInput <- reactive({
    #temporary variables for input values to be more comprehensive
    minrating <- input$rating[1]
    maxrating <- input$rating[2]
    minpace <- input$pace[1]
    maxpace <- input$pace[2]
    minshot <- input$shot[1]
    maxshot <- input$shot[2]
    minpass <- input$pass[1]
    maxpass <- input$pass[2]
    mindrible <- input$drible[1]
    maxdrible <- input$drible[2]
    mindefense <- input$defense[1]
    maxdefense <- input$defense[2]
    minphysic <- input$physic[1]
    maxphysic <- input$physic[2]
    
    #Applying input filters
    p <- db %>%
      filter(
        overall >= minrating,
        overall <= maxrating,
        
        pace >= minpace,
        pace <= maxpace,
      
        shooting >= minshot,
        shooting <= maxshot,
        
        passing >= minpass,
        passing <= maxpass,
        
        dribbling >= mindrible,
        dribbling <= maxdrible,
        
        defending >= mindefense,
        defending <= maxdefense,
        
        physicality >= minphysic,
        physicality <= maxphysic
      )
    
    #Finding player position
    if (input$pos != "All") {
      pos <- paste0(input$pos)
      p <- p %>% filter(position == pos)
    }
    #Finding nationality
    if (input$nation != "All") {
      nation <- paste0(input$nation)
      p <- p %>% filter(nationality == nation)
    }
    #Finding league
    if (input$league != "All") {
      leagues <- paste0(input$league)
      p <- p %>% filter(league == leagues)
    }
    p <- as.data.frame(p)
    p
  })
  
  # Function for generating tooltip text
  player_tooltip <- function(x) {
    if (is.null(x)) return(NULL)
    if (is.null(x$player_id)) return(NULL)
    
    # Pick out the player with this ID
    player <- db[db$player_id == x$player_id, ]
    paste0("<b>",player$player_name, "</b><br>", #negrito and paragraph
           "Overall rating: ",player$overall, "<br>",
           "Player position: ",player$position, "<br>",
           "Estimated Price: ",player$ps4_last, "<br>"
    )
    
  }
  # Function for the circle click
  click_tooltip <- function(x) {
    if (is.null(x)) return(NULL)
    if (is.null(x$player_id)) return(NULL)
    
    # Pick out the player with this ID
    clicked <-db[db$player_id == x$player_id, ]
  
    #putting into our data tab
    output$data1 <- renderDT({clicked}, options = list(scrollX = TRUE))
    paste0("<b>", "Added to the data", "</b>")
  }
  
  #Reactive with scatter ggplot
  vis <- reactive({
    dataInput %>%
      ggvis(x =  ~age, y =~overall) %>%
      layer_points(size := 50, size.hover := 100, fillOpacity := 0.2, fillOpacity.hover := 0.4,
                   stroke = ~pref_foot ,key := ~player_id) %>% #options for the circles
      add_tooltip(player_tooltip, "hover") %>%#adding tooltips
      add_tooltip(click_tooltip, "click") %>%
      scale_nominal("stroke", label= "Prefered Foot",
                    range = c("red", "blue")) %>%
      set_options(width = 700, height = 500)
  })
  
  vis %>% bind_shiny("plot1") #respective UI element
  }
