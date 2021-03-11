# Bank_Telemarketing

A Portuguese bank’s data is selected where bank ran a telemarketing campaign on existing customers to subscribe to their term deposit policy. The dataset contains information related to existing customer’s record with bank and records of telemarketing campaign.

The main objective is to predict customers' responses to future marketing campaigns, through classification models, so that the bank can focus its marketing efforts on the most responsive customers. The models would help the bank to secure deposits more efficiently, save marketing costs and reduce undesirable advertisements to customers.

 We can see that value of specificity and AUC is more for Naïve Bayes which shows that it performs better than SVM for True negative rates. ROC curve for both the model looks almost similar and since both are close to top-left corner it suggests nice trade-off between sensitivity and specificity.

Evaluation Metric 

            | Naïve Bayes | SVM 
---------------------------------
Accuracy    |  0.8138    | 0.8514 
Kappa       |  0.5863    | 0.6718 
Sensitivity |  0.7320    | 0.8944 
Specificity |  0.8559    | 0.7722 
AUC         |  0.8683    | 0.839 
