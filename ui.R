library(googleVis)


shinyUI(dashboardPage(
  skin = "yellow" ,
  dashboardHeader(title = "New York Real-State Analytics - Manhattan 2017 ",titleWidth = 1200),
  dashboardSidebar(
    
    sidebarUserPanel("Fatima Hamdan",image = 'https://ca.slack-edge.com/T03H6UV5A-U85TGD1GC-8139426649e9-72'),
    sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                      label = "Search..."),
    sidebarMenu(
      menuItem("Overview",tabName = "OverviewTab", icon= icon("fa fa-home")),
      menuItem("Data",tabName = "DataTab", icon= icon("fa fa-database")),
      menuItem("Map",tabName = "MapTab", icon= icon("fa fa-map-marker")),
      menuItem("Analysis",tabName = "AnalysisTab", icon= icon("fa fa-area-chart")),
      menuItem("Live People Searches",tabName = "GoogleSearchTab", icon= icon("fa fa-search")),
      menuItem("Contact Information",tabName = "ContactTab", icon= icon("fa fa-envelope" ))
      
      
   
    )),
  dashboardBody(
    tags$head(tags$style(HTML('
      .main-header .logo {
                              font-family: "Georgia", Times, "Times New Roman", serif;
                              font-weight: bold;
                              font-size: 24px;
                              }
                              '))),
    
    
    tabItems(
      tabItem(tabName = "OverviewTab",
            "first tab"),
      tabItem(tabName = "DataTab", 
            "second tab"),
      tabItem(tabName = "MapTab", 
              "third tab"),
      tabItem(tabName = "AnalysisTab", 
              fluidRow(
                box( width = 12, fluidRow( 
                                           column (12,offset=30,infoBox("New Orders", 10 * 2, icon = icon("credit-card"))),
                                           column (12,selectizeInput("selectedLocation","Location Name",width="300px",LocationName_Choices)),
                                           column (12,selectizeInput("selectedBuilding","Building Class Category",width="300px",BuildingClassCategory_Choices)),
                                           column (12,checkboxInput("selectedNewBuilding", "Newly Built (after year 2000)", value = FALSE, width = NULL)),
                                           column (12,checkboxInput("selectedOldBuilding", "Oldly Built (before year 2000)", value = FALSE, width = NULL)),
                                           column (12,sliderInput("PriceRange", "Choose Price Range", minPrice/2, maxPrice+300000, value = c(200000000,600000000),pre = "Dollars", step = 500000)),
                                           column (12,actionButton("FilterID", "Filter"))),
             
                tabBox(
                  title = "Analytics",
                  # The id lets us use input$tabset1 on the server to find the current tab
                  id = "tabset1", width= "3000px",height = "500px",
                  tabPanel("Tables", fluidRow(box(width= 12,DT::dataTableOutput("Table")))),
                  tabPanel("Graphs", fluidRow(box(width= 12,ggvisOutput("plot")))),
                  tabPanel("Maps", "Tab content 3")
                )))),
      
      tabItem(tabName = "GoogleSearchTab", 
              "fifth tab"),
      tabItem(tabName = "ContactTab", 
              "sixth tab")
      
      )
    
    
   )
    
  
    
  ))
