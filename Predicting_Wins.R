#Predicting Wins

data_lp = read.csv("league_players.csv")
data_ap = read.csv("ashford_matches.csv")

#EDA

data_ap[c("Win", "Loss", "Draw")] = list(
  ifelse(data_ap$goals_scored > data_ap$goals_conceded, 1, 0),
  ifelse(data_ap$goals_scored < data_ap$goals_conceded, 1, 0),
  ifelse(data_ap$goals_scored == data_ap$goals_conceded, 1, 0)
  )
#filling out the dataset with the outcomes for Win, Loss, Draw

data_ap$home_away = as.factor(data_ap$home_away)

results = aggregate(cbind(Win, Draw, Loss) ~ home_away,
                      data = data_ap, FUN = sum)
results
#we can see here that Ashford are definitely
#stronger at home than away which is to be expected in football
presults = aggregate(cbind(Win, Draw, Loss) ~ home_away,data = data_ap,
                      FUN = function(x) round(mean(x) * 100, 2))
presults
#winning ~65% of home games whilst losing ~43% of away games
#winning ~30% of away games whilst only losing ~13% of home games
#is impressive, considering it's a 46 game season

s = aggregate((goals_scored - goals_conceded) ~ home_away, 
          data = data_ap,FUN = function(x)
          c(Mean = round(mean(x), 2), Min = round(min(x), 2), 
            Max = round(max(x), 2), SD = round(sd(x), 2)
            ))
fs = data.frame(s[1], s[[2]])
print(fs)
#so on average, Ashford's GD away from home is ~-1 every 5 matches
#but when they're at home, they average a GD on 1.17 per game.
#we can also see that their games are close matches for the most part
#as their games on average only differ by 2 goals

#Modelling

pred_w = glm(Win ~ home_away + opponent_rank, data = data_ap, family = binomial)

summary(pred_w)
#we can see that the baseline for Ashford winning an away game is
#quite unlikely from our B_0 (Intercept); Which is expected given
#the data we've seen but also in football where you expect the home
#team to win.

#now when Ashford are at home, we see an increase of ~1.587 log odds
#of them winning in comparison to playing away from our B_1 (home_awayHome).
#We also have a statistically significant p value (0.0180) 
#which is < 0.05 meaning #that playing at home is a strong factor 
#and not just random noise

#when we factor opponent rank (B_2 opponnent rank) 
#after playing at home, the log odds of #winning increase by 0.088.
#Less statistically significant than home but significant to suggest
#that Ashford are more likely to beat teams lower in the table


#We also see that after adding our predictors to B_0, we have a ~9
#drop in deviance suggesting that the predictors explain the variations
#in match results decently well

exp(coef(pred_w))

#With our log odds coefficient of ~0.133 for the intercept, 
#we can see that the baseline (pos in table = 0) probability for 
#Ashford winning an away game #is ~11.7%  (0.133)/(1+0.133). 

#However, when we add playing at home, we see an increase of ~389%
#in odds of winning the game, showing that playing at home for Ashford is
#statistically significant and gives them a much better chance.

#We see similar results when opponent rank is considered and the
#location is constant; giving Ashford a ~9.2% increase the odds of 
#winning the match for each position you go down.

#We can test our theory by predicting specific scenarios,
#let's compare 3rd in the league vs 17th

test_theory = data.frame(
  home_away = factor(c("Home", "Home", "Away", "Away"), 
                                levels = levels(data_ap$home_away)),
                         opponent_rank = c(3,17,3,17))
test_theory$test_results = predict(pred_w, newdata = test_theory, type = "response") 

print(test_theory)

# home_away opponent_rank test_results
# 1      Home             3    0.4581291
# 2      Home            17    0.7445878
# 3      Away             3    0.1474413
# 4      Away            17    0.3735579

#Again we can see that playing at home signifcantly increases
#Ashford's chances of winning, even to the point where you're more
#likely to lose to 17th away than 3rd at home, just showing
#how much better Ashford are at home, even when playing much worse
#opponents