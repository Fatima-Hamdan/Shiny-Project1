

shinyServer(function(input,output){
 
  
  filtered_Data <- reactive({
    
    if(input$selectedLocation =='ANY LOCATION')
      FilteredLocation = (ManhattanSales$location_name == ManhattanSales$location_name)
    else
      FilteredLocation = (ManhattanSales$location_name==input$selectedLocation)
    
    if(input$selectedBuilding== "ANY TYPE OF BUILDING")
      FilteredBuilding = (ManhattanSales$building_class_category==ManhattanSales$building_class_category)
    else
      FilteredBuilding = (ManhattanSales$building_class_category==input$selectedBuilding)
    
    selectedminValue = input$PriceRange[1]
    selectedmaxValue = input$PriceRange[2]
    FilteredPrice = (ManhattanSales$sale_price > input$PriceRange[1] )&( ManhattanSales$sale_price < input$PriceRange[2])
  
    
    
    if(input$selectedNewBuilding == TRUE)
      FilteredNewBuilding = (ManhattanSales$year_built >= 2000)
    else 
      FilteredNewBuilding = (ManhattanSales$year_built==ManhattanSales$year_built)
    
    if(input$selectedOldBuilding == TRUE)
      FilteredOldBuilding = (ManhattanSales$year_built < 2000)
    else 
      FilteredOldBuilding = (ManhattanSales$year_built==ManhattanSales$year_built)
    
    if((input$selectedNewBuilding == TRUE)&&(input$selectedOldBuilding == TRUE)){
      FilteredOldBuilding=ManhattanSales$year_built
      FilteredNewBuilding=ManhattanSales$year_built
    }
    
    input$FilterID
  
   isolate( FilteredData <- filter(ManhattanSales,FilteredLocation,FilteredBuilding, FilteredPrice, FilteredNewBuilding,FilteredOldBuilding))
   
    
})
        
  filtered_Data %>%
    ggvis(~location_name, ~sale_price,fill =~building_class_category)%>% group_by(location_name) %>%
      layer_bars() %>%
    bind_shiny("plot1", "PriceRange")
  filtered_Data %>%
    ggvis(~location_name, ~sale_price,fill =~building_class_category)%>% group_by(location_name) %>%
    layer_bars() %>%
    bind_shiny("plot2", "PriceRange")
  filtered_Data %>%
    ggvis(~location_name, ~sale_price,fill =~building_class_category)%>% group_by(location_name) %>%
    layer_bars() %>%
    bind_shiny("plot3", "PriceRange")
  
  output$mymap <- renderLeaflet({
    leaflet(Andrew) %>%
      addProviderTiles("Esri.WorldStreetMap") %>%
      addPolylines(~Long, ~Lat)
  })
  
  output$mymap1 <- renderLeaflet({
    leaflet(Andrew) %>%
      addProviderTiles("Esri.WorldStreetMap") %>%
      addPolylines(~Long, ~Lat)
  })
  
  output$Table <- renderDT(filtered_Data(),options = list(scrollX = TRUE))

  
})