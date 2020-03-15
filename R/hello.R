# Function to demonstrate that we can write a function.  In this case, this function creates a neat ggplot based on
# input for the data, x and y axes, factor, title, and x and y labels
#' Title
#'
#' @param plot_data data with 3 columns: a dependent, independent, and controlling factor
#' @param x_input time-series such as year
#' @param y_input independent var such as % happy
#' @param factor_input factor to split the y_input such as race
#' @param factor_title_input label for the factor title
#' @param factor_labs_input labels for factors
#' @param title_input plot title
#' @param xlab_input x label
#' @param ylab_input y label
#' @param caption_input caption
#' @param ylim_input upper and lower bounds e.g. c(1.9,2.5)
#'
#' @return a plot of the data with a linear regression per factor
#' @export
#'
#' @examples
study_plotter <- function(plot_data, x_input, y_input, factor_input,
                          factor_title_input = factor_input,
                          factor_labs_input = NULL,
                          title_input = paste0("Plot of ", x_input, " by ", y_input),
                          xlab_input = x_input,
                          ylab_input = y_input,
                          caption_input = NULL,
                          ylim_input){

  # Evaluate the combination of the data and the x_input, y_input, and factor_input (allows for dynamic plotting)
  x_input_eval <- eval(parse(text = paste0(plot_data, "$", x_input)))
  y_input_eval <- eval(parse(text = paste0(plot_data, "$", y_input)))
  factor_input_eval <- eval(parse(text = paste0(plot_data, "$", factor_input)))

  # Set plot params
  g <- ggplot(eval(as.name(plot_data)), aes(x = x_input_eval, y = y_input_eval, color = factor(factor_input_eval)))

  # add plot elements and plot
  g + geom_point(size = .6) +
    geom_line(stat = "smooth",
              method = "lm",
              se = FALSE,
              alpha = 0.5) +
    theme_bw() +
    labs(title = title_input,
         x = xlab_input,
         y = ylab_input,
         caption = caption_input) +
    scale_color_manual(values=c("blue", "forestgreen", "dodgerblue"),
                       name=factor_title_input,
                       breaks=c(1, 2, 3),
                       labels=factor_labs_input) +
    coord_cartesian(ylim = ylim_input) # setting this to match the study excludes the lm via the above methodology
}
