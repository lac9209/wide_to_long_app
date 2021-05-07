longer_func <- function(dataset, group_columns, new_group_name, new_value_name) {
  # go wide to long
  new_data <- pivot_longer(data = dataset, 
                           cols = group_columns,
                           names_to = new_group_name,
                           values_to = new_value_name)
  return(new_data)
}