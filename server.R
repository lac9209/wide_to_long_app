server <- function(input, output, session) {
  
  # Read in file
  reactive_data <- reactive({
    # require input file
    req(input$file1) 
    
    inFile <- input$file1
    
    dat <- read.csv(inFile$datapath)
    
    # make all columns into characters (all same type)
    #dat <- dat %>%
    #  mutate(across(everything(), as.character))
    
    updateSelectizeInput(session, inputId = "Columns", label = "Group Variables",
                      choices = names(sapply(dat, is.numeric)), selected = NULL)
    
    return(dat)
  })
  
  # Print original data set
  output$table1 <- renderDataTable(reactive_data(), options = list(
    pageLength = 10,
    searching = FALSE
  ))

  # Make new data set from user input
  longer_data <- eventReactive(input$goButton, {
    
    # Error if the number of selected columns is equal to the total number of columns
    if(length(input$Columns) == ncol(reactive_data())){
      shinyWidgets::show_alert(
        title = "Incorrect Number of Columns Selected",
        text = "Select only the columns that represent the same overarching variable. You cannot select all variables.",
        type = 'error'
      )
    }
    
    # Error if no columns are selected
    else if(length(input$Columns) == 0){
      shinyWidgets::show_alert(
        title = "No Columns Selected",
        text = "Select the columns that represent the same overarching variable.",
        type = 'error'
      )
    }
    
    # Error if there is no Group Name
    else if (input$group_name == "") {
      shinyWidgets::show_alert(
        title = "Enter a Group Name",
        text = "Enter the name of the group variable",
        type = 'error'
      )
    }
    
    # Error if there is no Value Name
    else if (input$value_name == "") {
      shinyWidgets::show_alert(
        title = "Enter a Value Name",
        text = "Enter the name of the value variable",
        type = 'error'
      )
    }
    
    else{
      longer_func(reactive_data(), input$Columns, input$group_name, input$value_name)
    }
  })
  
  # Print new data set
  output$table2 <- renderDataTable(longer_data(), options = list(
    pageLength = 10,
    searching = FALSE
  ))
  
  # Show Download Button after making longer_data
  output$get_the_item <- renderUI({
    req(longer_data())
    downloadButton('downloadButton', label = 'Download Data Set') 
  })
  
  # Download Code -- file_name_clean.csv
  output$downloadButton <- downloadHandler(
    filename = function() {
      paste(gsub(".{4}$", "", input$file1), "_clean.csv", sep = "")
    },
    content = function(con) {
      write.csv(longer_data(), con, row.names = FALSE)
    }
  )
}






