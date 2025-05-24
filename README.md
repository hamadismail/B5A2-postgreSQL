## 1. Purpose of the `WHERE` Clause in a `SELECT` Statement

নির্দিষ্ট শর্ত-সাপেক্ষে টেবিল থেকে কোন রো ফিল্টার করার জন্য `WHERE` clause ব্যাবহার করা হয়।

---

`WHERE` clause ছাড়া:

```sql
SELECT * FROM rangers;
```

এই কুয়েরিটা টা rangers টেবলের সবগুলো রো রিটার্ন করবে।

`WHERE` clause ব্যাবহার করে:

```sql
SELECT * FROM rangers
WHERE region = 'Northern Hills';
```

এখন এই কুয়েরিটা টা শুধুমাত্র ওইসব রো গুলো রিটার্ন করবে যেগুলোর region 'Northern Hills' দেয়া।

## 2. What are the `LIMIT` and `OFFSET` Clauses Used For?

SQL এ `LIMIT` এবং `OFFSET` clauses number of rows কন্ট্রোল করার জন্য করার জন্য ব্যাবহার করা হয়।

---

### `LIMIT` Clause

রেজাল্ট সেট থেকে কতগুলো রো রিটার্ন করা হবে এটা `LIMIT` clause এর মাধ্যমে নির্দিষ্ট করা হয়।

#### Example:

```sql
SELECT * FROM sightings
LIMIT 5;
```

এই কুয়েরি টা sightings টেবিল থেকে প্রথম ৫টা রো রিটার্ন করবে।

### `OFFSET` Clause

OFFSET clause নির্দিষ্ট সংখ্যক রো স্কিপ করার জন্য ব্যাবহার হয়।

#### Example:

```sql
SELECT \* FROM sightings
OFFSET 5;
```

এই কুয়েরিটা প্রথম ৫টা রো স্কিপ করবে তারপর বাকি সবকিছু রিটার্ন করবে।

### Using LIMIT and OFFSET Together

ওয়ের অ্যাপ্লিকেশান এ pagination এর জন্য এইগুলা একসাথে ব্যাবহার করা হয়।

#### Example:

```sql
SELECT \* FROM sightings
ORDER BY sighting_time
LIMIT 10
OFFSET 20;
```

এই কুয়েরিটা প্রথম ২০ টা রো স্কিপ করে তার পরের ১০টা রো রিটার্ন করবে। (৩ নং পেইজ দেখাবে - যদি ১ পেইজে ১০ টা রো থাকে)

## 3. How Can You Modify Data Using `UPDATE` Statements?

SQL-এ UPDATE স্টেটমেন্টটি টেবিলে আগে থেকে থাকা ডেটা পরিবর্তন করার জন্য ব্যবহার করা হয়।

---

### Syntax

```sql
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;
```

`table_name`: যে টেবিলটা আপডেট করা হবে তার নাম।

`SET`: কলামগুলা এবং তাদের ভালু নির্দিষ্ট করে দিতে হবে।

`WHERE`: কোন রোগুলো আপডেট করা হবে তার কন্ডিশন দিয়ে দিতে হবে। কন্ডিশন না দিয়ে সব রো আপডেট হবে।

#### Example 1: Update One Field

```sql
UPDATE rangers
SET region = 'Highland Forest'
WHERE ranger_id = 2;
```

This updates Bob White's region to 'Highland Forest'.

#### Example 2: Update Multiple Fields

```sql
UPDATE species
SET conservation_status = 'Critically Endangered',
discovery_date = '1800-01-01'
WHERE species_id = 3;
```

এটা ৩নং id এর conservation_status এবং discovery_date এর ভালু আপডেট করবে।

## 4. What is the Significance of the `JOIN` Operation, and How Does It Work in PostgreSQL?

এক বা একাদিক টেবিল এর রোগুলো কম্বাইন করার জন্য SQL এ `JOIN` অপারেটর ব্যাবহার করা হয়।

---

### Common Types of Joins in PostgreSQL

| Join Type    | Description                                                                                          |
| ------------ | ---------------------------------------------------------------------------------------------------- |
| `INNER JOIN` | যে রোগুলো দুই টেবিলেই এক শুধুমাত্র সেগুলো রিটার্ন করবে।                                              |
| `LEFT JOIN`  | left টেবিল থেকে সবগুলো রো রিটার্ন করবে আর right টেবিল থেকে শুধুমাত্র যেগুলো মিলে ওইগুলো রিটার্ন করবে |
| `RIGHT JOIN` | right টেবিল থেকে সবগুলো রো রিটার্ন করবে আর left টেবিল থেকে শুধুমাত্র যেগুলো মিলে ওইগুলো রিটার্ন করবে |
| `FULL JOIN`  | যেকোনো এক টেবিলের সাথে মিললেই সবগুলো রো রিটার্ন করবে                                                 |

---

### Example: Joining Rangers and Sightings

```sql
SELECT r.name, s.location, s.sighting_time
FROM rangers r
JOIN sightings s ON r.ranger_id = s.ranger_id;
```

## 5. What is the `GROUP BY` Clause and Its Role in Aggregation Operations?

যেসব রো এর সেম ভালু আছে সেগুলো গ্রুপ করার জন্য SQL এ `GROUP BY` clause ব্যাবহার করা হয়।

---

### Purpose of `GROUP BY`

- সেম টাইপের ডাটাগুলোকে একসাথে করা হয়।
- প্রত্যেক গ্রুপ এ **aggregate calculations** করা হয়।

---

### Syntax

```sql
SELECT column1, AGGREGATE_FUNCTION(column2)
FROM table_name
GROUP BY column1;
```

`column1`: The column to group the result set by

`AGGREGATE_FUNCTION`: A function like COUNT(), SUM(), etc.

#### Example: Count Sightings per Ranger

```sql
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;
```

এটা ranger নাম এর মাধ্যমে ডাটাগুলোকে গ্রুপ করবে এবং প্রত্যেকটা গ্রুপ কত সংখ্যক sightings আছে ওইটা রিটার্ন করবে।
