# Dashboard con menú lateral con efectos visuales avanzados
library(shiny)
library(shinyjs)

library(bslib)
library(fontawesome) # Usaremos el paquete fontawesome de R
library("Rscience.import")
library("Rscience.GeneralLM")

ui <- page_sidebar(
  theme = bs_theme(
    bg = "#fff3e6", 
    fg = "#3d2c20",
    primary = "#e85d04",
    secondary = "#f48c06",
    success = "#198754",
    font_scale = 0.9
  ),
  
  # Encabezado
  title = span(
    "Rscience",
    class = "my-custom-title"  # Añadimos una clase personalizada al título
  ),
  
  # Menú lateral con efectos visuales
  sidebar = sidebar(
    title = "Control Panel",
    bg = "#ffe1c2",
    fg = "#3d2c20",
    width = 250,
    
    # JavaScript para efectos (sin dependencias externas)
    tags$script(HTML("
      $(document).ready(function() {
        $('#btn_primera').addClass('active');
        
        $('.btn-sidebar').click(function() {
          $('.btn-sidebar').removeClass('active');
          $(this).addClass('active');
          
          // Efecto de pulso al hacer clic
          $(this).addClass('pulse');
          setTimeout(function() {
            $('.btn-sidebar').removeClass('pulse');
          }, 500);
        });
      });
    ")),
    
    
    # Perfil de usuario
    div(
      class = "user-profile",
      div(class = "avatar"),
      div(
        class = "user-info",
        h5("Usuario Demo", style = "margin: 0; font-weight: 500;"),
        p("Admin", style = "margin: 0; font-size: 0.8rem; opacity: 0.7;")
      )
    ),
    
    # Separador
    div(class = "separator"),
    
    # Título de navegación
    p("NAVEGACIÓN", style = "font-size: 0.7rem; padding: 0 15px; font-weight: 600; color: #9a4012;"),
    
    # Botones de navegación usando fontawesome de R
    actionButton(
      "btn_primera", 
      span(fa_i("home"), span("Welcome", style="margin-left: 12px;")), 
      width = "100%",
      class = "btn-sidebar"
    ),
    
    actionButton(
      "btn_segunda", 
      span(fa_i("chart-line"), span("Rscience", style="margin-left: 12px;")), 
      width = "100%",
      class = "btn-sidebar"
    ),
    
    # Espacio flexible
    div(style = "flex-grow: 1;"),
    
    # Pie de página
    div(
      class = "sidebar-footer",
      tags$a(fa_i("github"), href = "#", class = "social-icon"),
      tags$a(fa_i("linkedin"), href = "#", class = "social-icon"),
      p("© 2023", style = "text-align: center; font-size: 0.8rem; margin-top: 10px; opacity: 0.7;")
    ),
    
    
    # Estilos CSS (sin importar de CDN)
    tags$style(HTML("
      .user-profile {
        display: flex;
        align-items: center;
        padding: 15px;
        margin: 15px 10px;
        background: linear-gradient(145deg, #ffdbb0, #ffe7c5);
        border-radius: 12px;
        box-shadow: 5px 5px 10px #d9c0a3, -5px -5px 10px #fff8eb;
      }
      
      .avatar {
        width: 40px;
        height: 40px;
        border-radius: 10px;
        background: linear-gradient(135deg, #e85d04, #f48c06);
        margin-right: 12px;
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
      }
      
      .avatar::after {
        content: 'U';
        font-weight: bold;
      }
      
      .user-info {
        flex: 1;
      }
      
      .separator {
        height: 2px;
        background: linear-gradient(90deg, #ffe1c200, #e85d0450, #ffe1c200);
        margin: 15px 0;
      }
      
      .btn-sidebar {
        display: flex;
        align-items: center;
        background: linear-gradient(145deg, #ffdbb0, #ffe7c5);
        border: none;
        color: #3d2c20;
        text-align: left;
        padding: 12px 15px;
        margin: 8px 10px;
        border-radius: 10px;
        box-shadow: 3px 3px 6px #d9c0a3, -3px -3px 6px #fff8eb;
        transition: all 0.3s;
      }
      
      .btn-sidebar i {
        margin-right: 12px;
        font-size: 1.1rem;
        width: 20px;
        text-align: center;
      }
      
      .btn-sidebar:hover {
        transform: translateX(5px);
      }
      
      .btn-sidebar.active {
        background: linear-gradient(135deg, #e85d04, #f48c06);
        box-shadow: inset 3px 3px 6px #dc580380, inset -3px -3px 6px #e67e0780;
        color: white;
      }
      
      .btn-sidebar.pulse {
        animation: pulse 0.5s;
      }
      
      @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(0.98); }
        100% { transform: scale(1); }
      }
      
      .sidebar-footer {
        padding: 15px;
        text-align: center;
        margin-top: 10px;
      }
      
      .social-icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 32px;
        height: 32px;
        background: linear-gradient(145deg, #ffdbb0, #ffe7c5);
        border-radius: 8px;
        margin: 0 5px;
        color: #3d2c20;
        box-shadow: 2px 2px 5px #d9c0a3, -2px -2px 5px #fff8eb;
        transition: all 0.3s;
      }
      
      .social-icon:hover {
        background: linear-gradient(135deg, #e85d04, #f48c06);
        transform: translateY(-3px);
        color: white;
      }
      
      .card-header.bg-primary {
        background-color: #e85d04 !important;
      }
      
      .card-header.bg-secondary {
        background-color: #f48c06 !important;
      }
    "))
  ),
  
  # Contenido principal con efecto de transición
  tags$style(HTML("
    #contenido_dinamico .card {
      transition: all 0.4s;
      animation: fadeIn 0.5s;
      box-shadow: 0 6px 12px rgba(232, 93, 4, 0.15);
      border: none;
    }
    
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }
  ")),
  
  uiOutput("contenido_dinamico")
)

server <- function(input, output, session) {
  # Variable reactiva para rastrear la página activa
  # Nota: si cambias esto, tambien tenes que cambiar el javascript para
  #  que tome el cambio.
  
  Rscience.GeneralLM::MASTER_module_Rscience_Main_server(id = "MASTER_MAIN")
  Rscience.GeneralLM::MASTER_module_fixed_anova_1_way_server(id = "super", show_dev = FALSE)
  
  active_page <- reactiveVal("primera")
  
  # Observar clics en botones
  observeEvent(input$btn_primera, {
    active_page("primera")
  })
  
  observeEvent(input$btn_segunda, {
    active_page("segunda")
  })
  
  
  
  output$la_primera <- renderUI({
    card(
      height = 200,
      card_header(
        "Dashboard Principal",
        class = "bg-primary text-white"
      ),
      card_body(
        div(
          style = "display: flex; justify-content: center; align-items: center; height: 100%;",
          h3("Bienvenido al Dashboard")
        )
      )
    )
  })
  
  output$la_segunda <- renderUI({
    div(
    # card(
    #   height = 200,
    #   card_header(
    #     "Análisis de Datos",
    #     class = "bg-secondary text-white"
    #   ),
    #   card_body(
    #     div(
    #       style = "display: flex; justify-content: center; align-items: center; height: 100%;",
    #       h3("Visualización de Análisis"),
    #       "",
    #       ""
    #     )
    #   )
    # ),
    Rscience.GeneralLM::MASTER_module_Rscience_Main_ui(id = "MASTER_MAIN"),
    Rscience.GeneralLM::MASTER_module_fixed_anova_1_way_ui(id = "super")
    )
  })
  # Contenido dinámico
  
  
  output$contenido_dinamico <- renderUI({
    
    switch (active_page(),
            "primera" = uiOutput("la_primera"),
            "segunda" = uiOutput("la_segunda")
    )
  })
}

# Aplicación Shiny
shinyApp(ui, server)
