## ----setup, echo = FALSE-------------------------------------------------
library(knitr)
opts_chunk$set(fig.path='figure/')

## ----load_data, echo = FALSE, message = FALSE----------------------------
# make sure dplyr comes first
select <- dplyr::select
library(PiperetalGMHBone)
# First load the data and code libraries. 
spit_depths <- read.csv("GMH_spit_depths.csv", stringsAsFactors = FALSE)
dates_input <- read.csv("GMH_C14_dates.csv", stringsAsFactors = FALSE)
my_libraries()

## ----excal_prep----------------------------------------------------------
# need to have:
# Name = lab code, Date = radiocarbon age, Uncertainty = error
dates_for_oxcal <- with(dates_input, data.frame(Name = DirectAMS.code,
                                          Date = BP,
                                          Uncertainty = X1s.error.1))
dates <- dates_for_oxcal 
oxcal_formatter(dates)
# now follow instructions in oxcal_formatter.R to use OxCal website
# now load output from OxCal website and put output in data folder

dates <- read.csv("GMH_C14_dates_OxCal_output.csv", stringsAsFactors = FALSE)
# combine with raw input table, prepare by making colnames useful
colnames(dates) <- c("Name", as.character(dates[1,])[2:7])
dates$DirectAMS.code <- gsub("R_Date ", "", dates$Name)
dates[,2:7] <- sapply(dates[,2:7], as.numeric)
dates_calib <- merge(dates_input, dates, by = 'DirectAMS.code')
# don't want to see the spit column as those are an early rough guess
# not a computed result
dates_calib <- select(dates_calib, -Excavation.unit..spit.)
# tidy up a little, remove spaces
dates_calib$material <- gsub("\\s", "", dates_calib$X)


## ------------------------------------------------------------------------
dates_calib

## ----shell_organic_dates-------------------------------------------------
# by material type

# function to extract a, b, r2, and p values

lm_eqn = function(df){
    m = lm(median ~ Depth.below.surface..m., df);
      out <-data.frame(a = coef(m)[1], 
                       b = coef(m)[2], 
                      r2 = summary(m)$r.squared,
                       p =  anova(m)$'Pr(>F)'[1],
                       n = nrow(df) )
    out                 
}
# compute linear models
models_x <- plyr::dlply(dates_calib, "material", function(i) 
     lm_eqn(i))
# present in tidy data frame
lm_coeffs <- do.call("rbind", models_x)


# for organics only: age = 3030.2 * depth -342.5
# check for differences in intercept to get offset

intercepts <- round(lm_coeffs$a,2)
difference <- round(sum(abs(intercepts)), 1)

# plot
limits <- with(dates_calib, ggplot2::aes(ymax = from, ymin = to))
ggplot(dates_calib, aes(Depth.below.surface..m., median, colour = material))   + # all, by colour
  geom_point(size = 4, aes(shape = material)) +
  geom_pointrange(limits, width = 2) +
  geom_smooth(se = FALSE, method = "lm") + 
  coord_flip() + 
  theme_minimal() + 
  scale_x_reverse() + 
  xlab("meters below surface") +
  ylab("cal yrs BP") +
  theme(axis.title.x=element_text(colour="black", size = 15),  
        # increase axis title size slightly  
        axis.title.y=element_text(colour="black", angle=90, size = 15),    
        # increase axis title size slightly and rotate
        axis.text.x=element_text(colour="black", size = 15),               
        # increase size of numbers on x-axis
        axis.text.y=element_text(colour="black", size = 15))               
        # increase size of numbers on y-axis


## ------------------------------------------------------------------------
lm_coeffs

## ----spit_depths---------------------------------------------------
# relate every spit depth back to the datum
spit_depths[] <- sapply(spit_depths, as.numeric)
relative_to_datum <- spit_depths$datum - spit_depths[,4:13]
# take average of start levels of spit one for
# ground surface relative to datum
ground_surface <- mean(as.numeric(relative_to_datum[1,1:4]))
# now compute relative to ground surface, this should give
# values that we can read as actual depths below the surface
relative_to_ground_surface <- relative_to_datum + abs(ground_surface)
relative_to_ground_surface$spit <- spit_depths$Spit
relative_to_ground_surface

# plot
spits_m <- melt(relative_to_ground_surface, id.var = 'spit')
spits_m$start_or_end <- ifelse(grepl("end", spits_m$variable), "end", "start")
remove <- c(".end", ".start")
spits_m$spit_start_or_end <- with(spits_m, paste0(spit, "_", start_or_end)) 
spits_m$variable <- gsub(paste(remove, collapse = "|"), "", spits_m$variable)
ggplot(spits_m, aes(variable, value, group = spit_start_or_end, linetype =  start_or_end, colour = start_or_end)) +
  geom_line() +
  theme_minimal() +
  scale_y_continuous(breaks = seq(-3,0,0.25)) +
  xlab("Measurement location") +
  ylab("Depth below surface (m)")

# how deep was spit nine?
nine_start <- round(mean(filter(spits_m, spit == 9, start_or_end == "start")$value),2)
nine_end <- round(mean(filter(spits_m, spit == 9, start_or_end == "end")$value),2)


## ----dated_sample_spits--------------------------------------------

dates_calib$section <- "SW."
# plot spits with dated samples
ggplot(spits_m, aes(variable, value)) +
  geom_line(aes(group = spit_start_or_end, linetype =  start_or_end, colour = start_or_end)) +
 geom_text(data = dates_calib, aes(section, -Depth.below.surface..m., label = DirectAMS.code), size = 1, hjust = 1.2) + 
  theme_minimal() +
  scale_y_continuous(breaks = seq(-3,0,0.25)) +
  xlab("Measurement location") +
  ylab("Depth below surface (m)")

## ------------------------------------------------------------------
# match sample depths up with a specific spit from SW-SE data
relative_to_ground_surface$South_means <- with(relative_to_ground_surface, apply(cbind(SE..end, SW..end), 1, mean))
South_depth_means <- sort(as.vector(na.omit(apply(cbind(relative_to_ground_surface$SE..end, relative_to_ground_surface$SW..end), 1, mean))), decreasing = FALSE)
intervals <- cbind(-dates_calib$Depth.below.surface..m., findInterval(-dates_calib$Depth.below.surface..m., South_depth_means))
means <- merge(data.frame(South_depth_means), relative_to_ground_surface, by.x = 'South_depth_means', by.y = 'South_means')
means <- arrange(means, South_depth_means)
# subset the table of spit depths with the intervals that the samples come from,
# and these are the spits that correlate with the depths that the dated samples
# were taken from in the South wall
df <- (list(means[intervals[,2], ]$spit,
           dates_calib$Depth.below.surface..m.,
           dates_calib$Name, 
           dates_calib$material,
           dates_calib$BP,
           dates_calib$to, 
           dates_calib$from))
df <- data.frame(sapply(df,'[',seq(max(sapply(df,length)))))
names(df) <- c("spit", "depth below surface", "code", "material", "uncal age","to cal BP", "from cal BP")
df

