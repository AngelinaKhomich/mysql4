use vk;

/* 1. Подсчитать количество групп (сообществ), в которые вступил каждый пользователь. */
SELECT user_id, COUNT(*) 'Количество групп'
FROM users_communities
GROUP BY user_id

/* 2. Подсчитать количество пользователей в каждом сообществе. */
SELECT c.name, COUNT(u_c.user_id)
FROM communities c
INNER JOIN users_communities u_c ON u_c.community_id=c.id
GROUP BY c.name

/* 3. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений). */
SELECT u.id, u.firstname, u.lastname
FROM messages m
INNER JOIN users u ON u.id=m.from_user_id
WHERE m.to_user_id = '1'
GROUP BY m.from_user_id
ORDER BY m.from_user_id DESC 
LIMIT 1;

/* 4. Подсчитать общее количество лайков, которые получили пользователи младше 18 лет.. */
SELECT COUNT(l.id) 'Количество лайков'
FROM likes l
INNER JOIN media m ON m.id=l.media_id
INNER JOIN profiles p ON p.user_id=m.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < '18';

/* 5. Определить кто больше поставил лайков (всего): мужчины или женщины. */

SELECT gender,COUNT(l.id) 'Количество лайков'
FROM likes l
INNER JOIN profiles p ON p.user_id=l.user_id
GROUP BY gender

    