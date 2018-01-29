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
              img(src ='https://cdn.pixabay.com/photo/2015/12/08/04/15/new-york-1082447_1280.jpg', align = "center")),
      tabItem(tabName = "DataTab", tags$h1(tags$b("To download the used dataset for the analysis, Copy this link:")),
              tags$a("http://www1.nyc.gov/site/finance/taxes/property-rolling-sales-data.page" ),
              img(src =' https://slack-files.com/T03H6UV5A-F913PESCX-5f2a87fb6c', align = "center"),
              tags$h3(tags$i("This is the NYC Department of Finance.The Annualized Sales files on this site display properties
                             sold in New York City(Bronx,Brooklyn,Manhattan,Queens,Staten Island) by year, beginning in 2003."))),
      tabItem(tabName = "MapTab", 
              box(width= 12,leafletOutput("mymap1"))),
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
                  tabPanel("Graphs", fluidRow(box(width= 12,ggvisOutput("plot1")),
                                              box(width= 12,ggvisOutput("plot2")),
                                              box(width= 12,ggvisOutput("plot3")))),
                  tabPanel("Maps", fluidRow(box(checkboxInput("show", "Show States", value = FALSE)),
                                            box(width= 12,leafletOutput("mymap")))
                          
                   ))))),
      
       tabItem(tabName = "GoogleSearchTab", tags$br(),tags$br(),tags$br(),tags$br(),tags$br(),
              tags$h1(tags$b(tags$i("Under construction using gtrendsR library.. Investors can analyse people's location interest
                      in the present moment before buyinh properties")))),
      tabItem(tabName = "ContactTab", 
              tags$h1(tags$b("For more information about this project, Contact us!")),
              tags$h2(tags$i("Email Address: fatima-hamdan@live.com")))
      
      )
    
    
   )
    
  
    
  ))