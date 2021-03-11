# Bank_Telemarketing

A Portuguese bank’s data is selected where bank ran a telemarketing campaign on existing customers to subscribe to their term deposit policy. The dataset contains information related to existing customer’s record with bank and records of telemarketing campaign.

The main objective is to predict customers' responses to future marketing campaigns, through classification models, so that the bank can focus its marketing efforts on the most responsive customers. The models would help the bank to secure deposits more efficiently, save marketing costs and reduce undesirable advertisements to customers.

 We can see that value of specificity and AUC is more for Naïve Bayes which shows that it performs better than SVM for True negative rates. ROC curve for both the model looks almost similar and since both are close to top-left corner it suggests nice trade-off between sensitivity and specificity.

Evaluation Metric 
---------------------------------
            | Naïve Bayes | SVM 
---------------------------------
Accuracy    |  0.8138    | 0.8514 
---------------------------------
Kappa       |  0.5863    | 0.6718
---------------------------------
Sensitivity |  0.7320    | 0.8944
---------------------------------
Specificity |  0.8559    | 0.7722
---------------------------------
AUC         |  0.8683    | 0.839 
---------------------------------

Recommendations
1. More appropriate timing

When implementing a marketing strategy, external factors, such as the time of calling, should also be carefully considered. The previous analysis points out that March, September, October and December had the highest success rates. Nevertheless, more data should be collected and analyzed to make sure that this seasonal effect is constant over time. If the trend has the potential to continue in the future, the bank should consider initiating its telemarketing campaign in fall and spring.

2. Smarter marketing design

By targeting the right customers, the bank will have more and more positive responses, and the classification algorithms would ultimately eliminate the imbalance in the original dataset. Hence, more accurate information will be presented to the bank for improving the subscriptions. Meanwhile, to increase the likelihood of subscription, the bank should re-evaluate the content and design of its current campaign, making it more appealing to its target customers.

3. Better services provision

With a more granular understanding of its customer base, the bank has the ability to provide better banking services. For example, marital status and occupation reveal a customer's life stage while loan status indicates his/her overall risk profile. With this information, the bank can estimate when a customer might need to make an investment. In this way, the bank can better satisfy its customer demand by providing banking services for the right customer at the right time.
