#attach packages

library(tidyverse)
library(shiny)
library(shinythemes)
library(here)

#read in spooky.data.csv

spooky<-read_csv(here("data","spooky_data.csv"))

#create user interface

#unique(spooky$state) will tell you what the things are that are unique in the data set

ui<-fluidPage(
  theme = shinytheme("cerulean"),
  titlePanel("Here is my awesome title"),
  sidebarLayout(
    sidebarPanel("My widgets are here",
                 selectInput(inputId = "state_select",
                             label = "Choose a state:",
                             choices = unique(spooky$state)) #you can list them like c("",) with "cc"="x" if it doesnt match also
                 ),
    mainPanel("My outputs are here!",
              tableOutput(outputId = "candy_table"))
  )
)

server<-function(input,output){

  state_candy<-reactive({
    spooky %>%
      filter(state==input$state_select) %>%
      select(candy,pounds_candy_sold)
  })

  output$candy_table<-renderTable({
    state_candy()
  })



} #function tells it what factors it should be looking at, input from ui, output what goes back to ui

shinyApp(ui=ui,server=server)









