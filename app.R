## Files
source("./wide_to_long/ui.R")
source("./wide_to_long/server.R")
source("./wide_to_long/function.R")


## Run the application 
shinyApp(ui = ui, server = server)
