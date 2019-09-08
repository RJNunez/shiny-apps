####
####
####  Adding some comments
####
####

library(shinythemes)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # -- Reactive dataset 1
    mvnData <- reactive({
        # -- Parameters of the MVN distribution
        set.seed(445)
        mu          <- matrix(0, nrow=2)
        sigma       <- matrix(input$corr, nrow=2, ncol=2)
        diag(sigma) <- 1

        # -- Matrix to save results
        results           <- matrix(NA, nrow=input$itr, ncol=2)
        results[,1]       <- 1:input$itr
        colnames(results) <- c("Index", "Correlation")

        for(i in 1:input$itr)
        {
            # -- Generating data
            obs <- mvrnorm(input$obs, mu=mu, Sigma=sigma)

            # -- Saving results
            results[i,2] <- cor(obs[,1], obs[,2])
        }
        return(results)
    })
    
    # -- Reactive dataset 2
    animationViz <- eventReactive(input$action, {
        
        plot(rnorm(10), rnorm(10))
        # -- Parameters that index the MVN distribution
        # mu          <- matrix(0, nrow=2)
        # sigma       <- matrix(0, nrow=2, ncol=2)
        # diag(sigma) <- 1
        # 
        # # -- Parameters for simulation
        # n <- seq(0,1000, by=10) # Sample Size
        # n <- n[-1]
        # R <- 100                # Number of iterations
        # 
        # res <- lapply(n, function(x){
        #     
        #     results     <- matrix(NA, nrow=R, ncol=3)
        #     results[,1] <- 1:R
        #     results[,3] <- x
        #     colnames(results) <- c("Index", "Correlation", "Sample.Size")
        #     
        #     for(i in 1:R)
        #     {
        #         # -- Generating data
        #         obs <- mvrnorm(x, mu=mu, Sigma=sigma)
        #         
        #         # -- Saving results
        #         results[i,2] <- cor(obs[,1], obs[,2])
        #     }
        #     
        #     return(results)
        # })
        # 
        # res <- do.call(rbind, res) %>%
        #     as_tibble() %>%
        #     mutate(Sample.Size = as.integer(Sample.Size))
        # 
        # animation <- ggplot(data=res, aes(Index, Correlation)) +
        #     geom_point(alpha=0.70, show.legend = FALSE, size=3, color="white") +
        #     geom_point(pch=1, show.legend = FALSE, size=3, color="white") +
        #     scale_y_continuous(limits=c(-1,1),
        #                        breaks = seq(-1,1,by=0.20)) +
        #     geom_hline(yintercept = 0, lty=2, color="red") +
        #     theme_classic() +
        #     theme(plot.background = element_rect(color = "black", fill = "black"),
        #           plot.title = element_text(face="bold", color = "white"),
        #           plot.subtitle = element_text(color="white"),
        #           
        #           axis.title = element_text(face="bold", color = "white"),
        #           axis.line.x  = element_line(size=1, color="white"),
        #           axis.ticks.x = element_line(size=1,color="white"),
        #           axis.text.x  = element_text(angle=0, hjust=0.50, face="bold", color = "white"),
        #           axis.line.y  = element_line(size=1, color="white"),
        #           axis.ticks.y = element_line(size=1,color="white"),
        #           axis.text.y  = element_text(face="bold", color = "white"),
        #           
        #           # Specify legend options
        #           legend.position = "bottom",
        #           legend.background = element_rect(color = NA, fill = "black"),
        #           legend.key = element_rect(color = "white",  fill = "black"),
        #           legend.text = element_text(color = "white", face="bold"),
        #           legend.title = element_text(face = "bold", hjust = 0, color = "white"),
        #           legend.text.align = NULL,
        #           legend.title.align = NULL,
        #           legend.box = NULL,
        #           
        #           # Specify panel options
        #           panel.background = element_rect(fill = "black", color  =  NA),
        #           
        #           # Specify facetting options
        #           strip.background = element_rect(fill = "white", color = "white"),
        #           strip.text.x = element_text(color = "black", face = "bold"),
        #           strip.text.y = element_text(color = "white",angle = -90)) +
        #     ##
        #     labs(title = 'Sample Size: {frame_time}', x = 'Index', y = 'Correlation') +
        #     transition_time(Sample.Size) +
        #     enter_fade() + 
        #     exit_fade() + 
        #     ease_aes('linear')
        # 
        # animate(animation, nframes = 100, duration = 100, fps = 1, end_pause = 2, rewind = FALSE)
    })
    
    ntext <- eventReactive(input$goButton, {
        input$corr
    })
    
    # -- Output 1
    output$distPlot <- renderPlot({

        mvnData() %>%
            as_tibble() %>%
            ggplot(aes(Index, Correlation)) +
            geom_point(color="black", size=3, alpha=0.70) +
            geom_point(color="black", pch=1, size=3) +
            xlab("Simulation") +
            ggtitle(paste("Correlation with a sample size of", input$obs)) +
            scale_y_continuous(limits=c(-1,1),
                               breaks = seq(-1,1,by=0.20)) +
            geom_hline(yintercept = input$corr, lty=2, color="red", size=1) +
            theme_classic() +
            theme(plot.title   = element_text(size=15,face="bold", color = "black"),
                  axis.title   = element_text(size=10, face="bold", color = "black"),
                  axis.line.x  = element_line(size=1, color="black"),
                  axis.ticks.x = element_line(size=1,color="black"),
                  axis.text.x  = element_text(size=10,angle=0, hjust=0.50, face="bold", color = "black"),
                  axis.line.y  = element_line(size=1, color="black"),
                  axis.ticks.y = element_line(size=1,color="black"),
                  axis.text.y  = element_text(size=10,face="bold", color = "black"))
    })
})
