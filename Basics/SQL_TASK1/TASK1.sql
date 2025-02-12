
-- Creating database task2

create database task2 ;

-- Using task2

use task2 ;

--  Creating table unlabeled_image_predictions

CREATE TABLE IF NOT EXISTS unlabeled_image_predictions (
    image_id INT,
    score FLOAT
);

-- Inserting data into unlabeled_image_predictions

INSERT INTO unlabeled_image_predictions (image_id, score) VALUES
    (828, 0.3149), 
    (705, 0.9892), 
    (46, 0.5616), 
    (594, 0.7670), 
    (232, 0.1598), 
    (524, 0.9876), 
    (306, 0.6487), 
    (132, 0.8623), 
    (906, 0.8394), 
    (272, 0.9778), 
    (616, 0.1003), 
    (161, 0.7113), 
    (715, 0.8921), 
    (109, 0.1151), 
    (424, 0.7790), 
    (609, 0.5241), 
    (63, 0.2552), 
    (276, 0.2672), 
    (701, 0.0758), 
    (554, 0.4418), 
    (998, 0.0379), 
    (809, 0.1058), 
    (219, 0.7143), 
    (402, 0.7655), 
    (439, 0.3387), 
    (464, 0.3674), 
    (405, 0.6929), 
    (363, 0.2661), 
    (624, 0.8270), 
    (640, 0.8790), 
    (913, 0.2421), 
    (986, 0.8931), 
    (344, 0.3761), 
    (847, 0.4889), 
    (482, 0.5023), 
    (823, 0.3361), 
    (617, 0.0218), 
    (47, 0.0072), 
    (867, 0.4050), 
    (96, 0.4498), 
    (126, 0.3564), 
    (943, 0.0452), 
    (115, 0.5309), 
    (417, 0.7168), 
    (706, 0.9649), 
    (166, 0.2507), 
    (991, 0.4191), 
    (465, 0.0895), 
    (53, 0.8169), 
    (971, 0.9871);
    
    
    
-- POSITIVE SAMPELING

    --   Approach ->  1. Inside subquery ROW_NUMBER() window function is used 
                 --      to assign row number to every row after sorting it on 
                 --      the basis of score in decreasing order .
                 --   2. Now the row number (i.e. seq) is used to filter every 
                 --      third row starting from first by doing (seq%3 = 1) .
                 --   3. Resultant table is order by image id and take max to max 
                 --      10k entries by using limit .
                 --   4. Weak label column is added by rounding off score using ROUND()
                 --      functioin .


SELECT image_id, 
       IF(ROUND(score) = 0, 0 , 1) AS weak_label 
FROM (
    SELECT image_id, score, 
           ROW_NUMBER() OVER (ORDER BY score DESC) AS seq 
    FROM unlabeled_image_predictions
) AS x
WHERE seq % 3 = 1
ORDER BY image_id
LIMIT 100000 ;

-- NEGATIVE SAMPELING 

    --   Approach ->  1. Inside subquery ROW_NUMBER() window function is used 
                 --      to assign row number to every row after sorting it on 
                 --      the basis of score in increasing order .
                 --   2. Now the row number (i.e. seq) is used to filter every 
                 --      third row starting from first by doing (seq%3 = 1) .
                 --   3. Resultant table is order by image id and take max to max 
                 --      10k entries by using limit .
                 --   4. Weak label column is added by rounding off score using ROUND()
                 --      functioin .

SELECT image_id, 
       IF(ROUND(score) = 0, 0 , 1) AS weak_label
FROM (
    SELECT image_id, score, 
           ROW_NUMBER() OVER (ORDER BY score) AS seq1 
    FROM unlabeled_image_predictions
) AS x
WHERE seq % 3 = 1
ORDER BY image_id
LIMIT 100000 ;

select image_id , score from unlabeled_image_predictions ;

