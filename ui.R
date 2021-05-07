ui <- fluidPage(
  
  # Application title
  titlePanel("Wide to Long Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # Read in file
      fileInput("file1", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values, text/plain",
                  ".csv")
      ),
     
      # Select Group Variables
      selectizeInput('Columns', 'Group Variables', choices = "", multiple = TRUE),
      
      # Text input field for group names
      textInput("group_name", label = h3("Group Name"), value = ""),
      
      # Text input field for value names
      textInput("value_name", label = h3("Value Name"), value = ""),
      
      # Action button
      actionButton("goButton", "Run", class = "btn-primary"),
      
      # Download button
      uiOutput("get_the_item")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      dataTableOutput("table1"),
      dataTableOutput("table2")
    )
  )
)