# Put any ideas of questions in here
1) What predicts a player getting injured?
2) What determines how many points Ashford get? Home / Away vs Opponent rank
3) How exactly do Ashford get their results? Scoring more, conceding less etc 
4) Are older players more likely to have previous injuries?
5) Do players with more previous injuries have a higher probability of being injured?
6) Is age associated with whether a player is injured?
7) Does injury prevalence differ between playing positions?
8) Does Ashford United score more goals at home than away?
9) Are shots on target associated with goals scored?





1. Binary logistic regression
   
Is age associated with the probability of a player being injured?	injured ~ age
Are previous injuries associated with current injury status?	injured ~ prev_injuries
Are age and previous injuries jointly associated with injury status?	injured ~ age + prev_injuries
Is training load associated with injury status, after accounting for age?	injured ~ training_load + age
Does injury risk differ by position after accounting for age?	injured ~ position + age


3. Chi-square test of independence
Use when you want to test association between two categorical variables.
Possible research question	Variables
Does injury status differ by playing position?	position × injured
Is injury status associated with team?	team × injured
Does Ashford's match result differ between home and away games?	home_away × result
Is scoring at least one goal associated with playing at home?	home_away × scored_any
Is conceding at least one goal associated with playing at home?	home_away × conceded_any
Best option: Does injury status differ by playing position?

4. Poisson regression

Are shots on target associated with goals scored?	goals_scored ~ shots_on_target
Is home advantage associated with goals scored?	goals_scored ~ home_away
Are home advantage and shots on target associated with goals scored?	goals_scored ~ home_away + shots_on_target
Is opponent rank associated with goals scored?	goals_scored ~ opponent_rank
Are shots on target and opponent rank associated with goals scored?	goals_scored ~ shots_on_target + opponent_rank
Are shots on target associated with goals conceded?	goals_conceded ~ shots_on_target

Best option: Are home advantage and shots on target associated with Ashford United’s goals scored?

4. Linear regression

Is age associated with minutes played?	minutes_played ~ age
Is training load associated with minutes played?	minutes_played ~ training_load
Is BMI associated with training load?	training_load ~ bmi
Are age and position associated with minutes played?	minutes_played ~ age + position
Is possession associated with goals scored?	goals_scored ~ possession

Best option: Is age associated with minutes played?

5. t-test or Wilcoxon test

Is mean age different between injured and non-injured players?	Welch two-sample t-test
Do injured and non-injured players differ in previous injury counts?	Wilcoxon rank-sum test
Does training load differ between injured and non-injured players?	Welch t-test or Wilcoxon
Do Ashford's goals scored differ between home and away matches?	Welch t-test or Wilcoxon
