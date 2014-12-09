SwiftKey Project
========================================================
author: Fred Zheng Zhenhao
date: 2014/12/10
font-family: 'Helvetica'
<small> This powerpoint is an explanatory document for the Shiny App,
please fo to this page for real experience. 
https://fredzheng.shinyapps.io/Swiftkey/
</small>

Current situation
========================================================

A lot of text input apps nowaday is already very advanced. They predict the next word in a very short time. 

One of the well known text input apps is TouchPal.It is nice to use. But it takes more than 20M to download.

Some simple input methods are small in size, but with limited predictability.

**_UltraWord Beta_** uses a sophisticated algorithm that makes the app small in size and easy to use.

Target at people who has an low-end phone, seeking for a portable input methods which doesn't stuck. 

Advantages -- Time
========================================================




```r
## What we use -- backoff model
system.time(backoff("Nice to see")) 
```

```
   user  system elapsed 
   0.01    0.00    0.01 
```

```r
## Combination of 1,2,3-gram
system.time(weighted("Nice to see"))
```

```
   user  system elapsed 
   0.05    0.00    0.05 
```
Our backoff model takes far less time than combined n-gram model. What's more, it only takes 1.66M to download (core part). 


Accuracy & options
========================================================


It's too bad that the accuracy of one prediction is only 11.5%. 

However, if we allow 2 predictions, the accuracy will increase to 14.4%, and if we allow 5 predictions, the accuracy will be 23.2%.

Additionaly, it provides two options for users to choose from:
  
  1. **Number of predictions:**  
  This sliderbar allows users to see more than one predictions from which users can choose from.
  
  2. **Only show one word:**  
  If users allow this algorithm to predict phrases, it can do so at the beginning of the sentence. 

Further improvement
========================================================
We think further development can be made in following area:

  1. **Adaptive algorithm**  
  It's totally possible to collect the text typed by users and integrate them into the input document-term matrix
  
  2. **Accuracy**  
  This accuracy is not so high, but it already performs well in predicting common phrases like "I'll be there", "I can't wait to" etc.
  
  3. **App-specific**  
  Since people have different behavior, if we build seperate predictive algorithms, the accuracy should be higher
  
  
