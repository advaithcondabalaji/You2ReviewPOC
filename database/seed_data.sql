-- Disable foreign keys temporarily for a clean overwrite of seed data
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE review_tags;
TRUNCATE TABLE reviews;
TRUNCATE TABLE movies;
SET FOREIGN_KEY_CHECKS = 1;

-- Insert 70 Real-World Movies (2024-2026 & Legendary Hits)
INSERT INTO movies (title, release_year, genre, runtime, director, synopsis, poster_url, overall_rating, positive_pct, mixed_pct, negative_pct, ai_verdict)
VALUES 

-- =========================================================================
-- !!! NEW 2026 RELEASES & CURRENT THEATER HITS !!! (Movies 1-15)
-- =========================================================================
(
    'The Odyssey', 2026, 'Sci-Fi / Adventure', '2h 35m', 'Christopher Nolan', 
    'A high-concept space-faring adaptation of classic journey elements, following a crew navigating uncharted dimensional rifts.',
    'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?auto=format&fit=crop&w=600&q=80',
    9.1, 88, 8, 4,
    'Audiences are calling Christopher Nolan’s latest a breathtaking cinematic event. The visual effects and complex story structure are highly praised, though a few viewers complain the intricate sound design sometimes drowns out key dialogue.'
),
(
    'Moana', 2026, 'Adventure / Fantasy', '2h 10m', 'Thomas Kail', 
    'The live-action adaptation of Disney’s beloved epic voyage, starring Catherine Laga''aia and Dwayne Johnson.',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=600&q=80',
    8.2, 74, 18, 8,
    'A vibrant and respectful adaptation. Dwayne Johnson’s live-action Maui and the gorgeous oceanic visuals are huge crowd-pleasers. Critics note that while it hits every beat of the animated classic perfectly, it rarely takes big risks.'
),
(
    'Obsession', 2026, 'Horror / Thriller', '1h 48m', 'Unknown', 
    'A tense, modern psychological horror that has taken the box office by storm, capturing an intense tale of modern paranoia.',
    'https://images.unsplash.com/photo-1509248961158-e54f6934749c?auto=format&fit=crop&w=600&q=80',
    8.5, 82, 11, 7,
    'A certified breakout hit of the year. Viewers are calling this psychological thriller intensely claustrophobic and deeply unsettling, praising the outstanding performances. Some horror fans felt the final twist was slightly predictable.'
),
(
    'Avengers: Doomsday', 2026, 'Action / Sci-Fi', '2h 45m', 'Anthony and Joe Russo', 
    'The Avengers face their ultimate multiversal challenge as the mysterious and tyrannical Doctor Doom emerges.',
    'https://images.unsplash.com/photo-1635805737707-575885ab0820?auto=format&fit=crop&w=600&q=80',
    8.9, 85, 10, 5,
    'An electric, stadium-status theater experience. The theater erupted for the return of familiar faces, and the dramatic weight of the villain lived up to the hype. Some fans noted the complex multiversal timeline math got confusing.'
),
(
    'Project Hail Mary', 2026, 'Sci-Fi / Drama', '2h 22m', 'Phil Lord & Christopher Miller', 
    'An astronaut wakes up with amnesia on a desperate, high-stakes solo mission to save humanity from an extinction-level event.',
    'https://images.unsplash.com/photo-1454789548928-9efd52dc4031?auto=format&fit=crop&w=600&q=80',
    9.0, 89, 8, 3,
    'Audiences fell completely in love with this adaptation, praising the incredible humor, heart, and chemistry between the lead actor and his alien companion. Highly faithful to the book and visually spectacular.'
),
(
    'The Batman Part II', 2026, 'Action / Crime', '2h 50m', 'Matt Reeves', 
    'Bruce Wayne plunges deeper into the frozen, flooded ruins of Gotham as a new criminal syndicate rises to fill the power vacuum.',
    'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=600&q=80',
    8.8, 84, 11, 5,
    'A magnificent, pitch-black detective thriller. Audiences loved the incredibly tense atmosphere and brilliant world development. Like the first film, some viewers complained that the long runtime is felt in the second act.'
),
(
    'Toy Story 5', 2026, 'Animation / Family', '1h 40m', 'Andrew Stanton', 
    'Woody, Buzz, and the gang must face a brand new threat to playtime: the rise of electronic tablet screens.',
    'https://images.unsplash.com/photo-1558060370-d644479cb6f7?auto=format&fit=crop&w=600&q=80',
    7.3, 55, 30, 15,
    'The animation is visually gorgeous, and the commentary on kids choosing tablets over physical toys was clever. However, a large portion of the audience felt the franchise already had two perfect endings and didn''t need another sequel.'
),
(
    'Supergirl: Woman of Tomorrow', 2026, 'Sci-Fi / Adventure', '2h 10m', 'Craig Gillespie', 
    'Kara Zor-El travels across the cosmos with her loyal dog to help a young alien girl seek revenge against the outlaws who destroyed her home.',
    'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?auto=format&fit=crop&w=600&q=80',
    8.2, 77, 16, 7,
    'A visually dazzling, space-faring western that stands out as completely unique. Audiences praised the beautiful pastel-colored cosmic cinematography and the badass, cynical take on Supergirl.'
),
(
    'The Hunger Games: Sunrise on the Reaping', 2026, 'Action / Drama', '2h 15m', 'Francis Lawrence', 
    'Return to Panem for the Fifty-Second Hunger Games, centering on the fateful reaping of Haymitch Abernathy.',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=600&q=80',
    8.4, 79, 14, 7,
    'A dark, highly engaging prequel that fans of the books are calling a triumphant return to form. The retro-Panem world design is top-notch, though some pacing in the arena segment felt slightly rushed.'
),
(
    'Narnia', 2026, 'Fantasy / Adventure', '2h 20m', 'Greta Gerwig', 
    'A fresh, magical reimagining of CS Lewis’s legendary portal fantasy world under Greta Gerwig’s direction.',
    'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=600&q=80',
    8.6, 81, 13, 6,
    'Visually spectacular and emotionally deep. Greta Gerwig’s return to literary adaptations captures the warm, childhood wonder of Narnia with a modern touch. A few fantasy purists felt some lore changes were unnecessary.'
),
(
    'The Cat in the Hat', 2026, 'Animation / Comedy', '1h 32m', 'Erica Rivinoja', 
    'A highly stylized animated feature of the mischievous Cat who turns a rainy afternoon upside down.',
    'https://images.unsplash.com/photo-1508341591423-4347099e1f19?auto=format&fit=crop&w=600&q=80',
    7.5, 62, 26, 12,
    'Bill Hader’s voice performance is a comedic highlight, and the vibrant, mid-century art style is incredibly cool. Many parents found the slapstick humor perfectly targeted for kids, though the story beats are quite simple.'
),
(
    'Violent Night 2', 2026, 'Action / Comedy', '1h 52m', 'Tommy Wirkola', 
    'David Harbour’s badass Santa Claus returns to dispatch a brand-new threat targeting a holiday gathering.',
    'https://images.unsplash.com/photo-1543536448-d209d2d13a1c?auto=format&fit=crop&w=600&q=80',
    7.6, 68, 20, 12,
    'Just as bloody, funny, and chaotic as the original. Audiences loved the creative use of Christmas decorations for R-rated action, though the storyline of the family under siege felt very similar to the first installment.'
),
(
    'Evil Dead Burn', 2026, 'Horror / Thriller', '1h 45m', 'Sébastien Vanicek', 
    'A terrifying new chapter of Deadite containment in an urban high-rise setting, bringing brutal, visceral horror.',
    'https://images.unsplash.com/photo-1505635552518-3448ff116af3?auto=format&fit=crop&w=600&q=80',
    7.9, 71, 18, 11,
    'Horror fans praised the extreme gore, relentless pacing, and creative camera work. Some legacy fans, however, missed the classic goofy humor of the older films, finding this version pitch-black and incredibly intense.'
),
(
    'Ready or Not 2: Here I Come', 2026, 'Comedy / Horror', '1h 38m', 'Radio Silence', 
    'Grace must survive yet another terrifyingly chaotic wedding night game with high-stakes survival rules.',
    'https://images.unsplash.com/photo-1513151233558-d860c5398176?auto=format&fit=crop&w=600&q=80',
    8.0, 78, 15, 7,
    'A highly underrated horror-comedy sequel. Fans of the original loved the witty script, Samara Weaving’s stellar performance, and the ramped-up scale of the family estate madness.'
),
(
    'The Rivals of Amziah King', 2026, 'Crime / Thriller', '2h 10m', 'Andrew Patterson', 
    'A gritty, pacing-heavy crime thriller tracking secrets and high-stakes standoffs in rural Oklahoma.',
    'https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?auto=format&fit=crop&w=600&q=80',
    8.3, 80, 12, 8,
    'Patterson delivers a slow-burn masterpiece featuring an incredibly deep performance by Matthew McConaughey. Critics praised the hypnotic cinematography, though casual action fans found the pacing too slow.'
),

-- =========================================================================
-- !!! THE 2025 HIT PARADE !!! (Movies 16-30)
-- =========================================================================
(
    'Superman', 2025, 'Action / Sci-Fi', '2h 30m', 'James Gunn', 
    'Superman journeys to reconcile his Kryptonian heritage with his human upbringing in Smallville, Kansas.',
    'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?auto=format&fit=crop&w=600&q=80',
    8.7, 83, 11, 6,
    'Audiences found this to be a wonderfully bright, hopeful, and deeply touching reimagining of the Man of Steel. The soundtrack and heart of the story were widely praised, while some felt the inclusion of other superheroes made the universe feel a bit crowded early on.'
),
(
    'Avatar: Fire and Ash', 2025, 'Sci-Fi / Adventure', '3h 0m', 'James Cameron', 
    'Jake Sully and Neytiri encounter an aggressive, fire-dwelling clan of Na''vi on Pandora known as the Ash People.',
    'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=600&q=80',
    8.5, 79, 15, 6,
    'Once again, James Cameron delivers a visual masterclass that demands to be seen in 3D. The darker thematic elements and new clans were highly intriguing, though some viewers pointed out the familiar structural beats of the prior films.'
),
(
    'Mickey 17', 2025, 'Sci-Fi / Comedy', '2h 19m', 'Bong Joon Ho', 
    'An "expendable" employee sent to colonize an ice world refuses to let his clone replacement take his place.',
    'https://images.unsplash.com/photo-1506318137071-a8e063b4bec0?auto=format&fit=crop&w=600&q=80',
    8.4, 78, 14, 8,
    'A highly unique, dark sci-fi comedy with stellar acting in a dual role. The bizarre tone and sharp corporate satire resonated with fans of the director, though it might be a bit too weird for mainstream blockbuster audiences.'
),
(
    'Captain America: Brave New World', 2025, 'Action / Thriller', '2h 15m', 'Julius Onah', 
    'Sam Wilson takes on the mantle of Captain America, finding himself in the middle of a massive international conspiracy.',
    'https://images.unsplash.com/photo-1569003339405-ea396a5a8a90?auto=format&fit=crop&w=600&q=80',
    7.5, 61, 24, 15,
    'Viewers appreciated the return to the grounded, political thriller style of The Winter Soldier. However, criticisms targeted the heavy CGI and some disjointed plotlines resulting from extensive reshoots.'
),
(
    'Thunderbolts*', 2025, 'Action / Sci-Fi', '2h 10m', 'Jake Schreier', 
    'A group of reformed villains and anti-heroes are sent on a covert government mission that goes completely wrong.',
    'https://images.unsplash.com/photo-1531259683007-016a7b628fc3?auto=format&fit=crop&w=600&q=80',
    7.8, 71, 19, 10,
    'Audiences loved the dynamic, dysfunctional "found family" banter and the gritty street-level action. Some felt the main antagonist was underdeveloped and resolved too quickly.'
),
(
    'The Fantastic Four: First Steps', 2025, 'Action / Sci-Fi', '2h 15m', 'Matt Shakman', 
    'Set in a retro-futuristic 1960s, Marvel''s first family must defend Earth from the world-consuming Galactus.',
    'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=600&q=80',
    8.3, 79, 14, 7,
    'Audiences absolutely adored the stylish, retro-futuristic 1960s aesthetic and the warm family dynamic of the main cast. The scale of the threat was praised, though some found the cosmic explanations in the third act a bit rushed.'
),
(
    'A Minecraft Movie', 2025, 'Adventure / Fantasy', '1h 45m', 'Jared Hess', 
    'Four misfits are pulled through a mysterious portal into the blocky, imaginative wonderland of the Overworld.',
    'https://images.unsplash.com/photo-1605899435973-ca2d1a8861cf?auto=format&fit=crop&w=600&q=80',
    5.4, 30, 32, 38,
    'Highly controversial. Kids generally enjoyed the colorful blocks and goofy humor, but older gaming fans heavily criticized the weird blend of live-action actors with hyper-realistic CGI blocks, finding it visually jarring.'
),
(
    'Jurassic World Rebirth', 2025, 'Action / Sci-Fi', '2h 10m', 'Gareth Edwards', 
    'An expedition secures crucial DNA samples from the world''s three most colossal prehistoric creatures remaining.',
    'https://images.unsplash.com/photo-1560114928-40f1f1eb26a0?auto=format&fit=crop&w=600&q=80',
    7.6, 64, 25, 11,
    'Audiences praised the tense, atmospheric, horror-tinged directing style, which felt much closer to the original Spielberg film. Some felt the overall story structure was a bit too simple.'
),
(
    'F1', 2025, 'Drama / Sport', '2h 20m', 'Joseph Kosinski', 
    'A former Formula 1 driver returns to the grid to mentor and team up with a young prodigy.',
    'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?auto=format&fit=crop&w=600&q=80',
    8.6, 82, 13, 5,
    'The absolute gold standard for racing movies. Audiences were blown away by the real-speed, in-cockpit IMAX cameras and incredible sound design. The story is predictable, but the cinematic execution is flawless.'
),
(
    'Sinners', 2025, 'Horror / Thriller', '1h 55m', 'Ryan Coogler', 
    'Two twin brothers return to their Southern hometown to start over, only to discover an even greater evil waiting for them.',
    'https://images.unsplash.com/photo-1505635552518-3448ff116af3?auto=format&fit=crop&w=600&q=80',
    8.4, 80, 14, 6,
    'A incredibly intense, atmospheric gothic horror film. Audiences loved the dark Southern vibe, fantastic leading performances, and a truly terrifying monster design. A few found the pacing of the setup a bit slow.'
),
(
    'The Bride!', 2025, 'Sci-Fi / Drama', '2h 12m', 'Maggie Gyllenhaal', 
    'A lonely Frankenstein''s monster travels to 1930s Chicago to seek the aid of a doctor in creating a companion.',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=600&q=80',
    8.1, 75, 17, 8,
    'A wonderfully chic, stylish, and highly musical spin on classic Frankenstein lore. Christian Bale and Jessie Buckley shine, though some felt it focused more on gothic fashion than actual sci-fi horror.'
),
(
    'Elio', 2025, 'Animation / Sci-Fi', '1h 39m', 'Adrian Molina', 
    'An underdog boy with a big imagination finds himself accidentally beamed up to the Communiverse as the leader of Earth.',
    'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=600&q=80',
    7.9, 72, 21, 7,
    'Pixar delivers another highly creative universe with a touching parent-child relationship. While visually stunning, some older fans felt the narrative played it a bit too safe compared to Pixar classics.'
),
(
    'The Black Phone 2', 2025, 'Horror / Thriller', '1h 47m', 'Scott Derrickson', 
    'The terrifying entity of the Grabber returns to haunt a new group of neighborhood kids with paranormal clues.',
    'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?auto=format&fit=crop&w=600&q=80',
    7.4, 63, 24, 13,
    'Audiences loved Ethan Hawke’s return, which is just as creepy as before. The tension remains high, but some felt the sequel lacked the element of surprise that made the original phone calls so iconic.'
),
(
    '28 Years Later', 2025, 'Horror / Thriller', '2h 0m', 'Danny Boyle', 
    'Decades after the initial rage virus outbreak, society has reformed in bizarre ways, but a new, faster mutation threatens the peace.',
    'https://images.unsplash.com/photo-1509248961158-e54f6934749c?auto=format&fit=crop&w=600&q=80',
    8.5, 81, 13, 6,
    'Danny Boyle’s raw, kinetic direction makes this feel incredibly fresh. Audiences raved about the visceral, stressful action and the smart world-building, and many found it a worthy successor to the original.'
),
(
    'Snow White', 2025, 'Fantasy / Family', '2h 5m', 'Marc Webb', 
    'A live-action adaptation of the classic Brothers Grimm fairy tale, filled with musical numbers and scenic landscapes.',
    'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?auto=format&fit=crop&w=600&q=80',
    6.1, 41, 33, 26,
    'Highly controversial. Audiences were split on the CGI dwarfs and some modern changes to the romantic plot beats. The musical performances, however, were widely praised for their pitch-perfect execution.'
),

-- =========================================================================
-- !!! THE 2024 BLOCKBUSTERS !!! (Movies 31-45)
-- =========================================================================
(
    'Dune: Part Two', 2024, 'Sci-Fi / Adventure', '2h 46m', 'Denis Villeneuve', 
    'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=600&q=80',
    9.1, 88, 8, 4,
    'Audiences are calling this a modern sci-fi masterpiece with breathtaking visuals and an incredible musical score. While almost everyone praised the acting and scale, a small minority felt the pacing dragged slightly in the middle act.'
),
(
    'Deadpool & Wolverine', 2024, 'Action / Comedy', '2h 7m', 'Shawn Levy', 
    'Wolverine recovers from his injuries when he crosses paths with the loudmouth Deadpool. They team up to defeat a common enemy.',
    'https://images.unsplash.com/photo-1635805737707-575885ab0820?auto=format&fit=crop&w=600&q=80',
    8.6, 81, 12, 7,
    'A hilarious, action-packed crowd pleaser. Fans absolutely loved the brilliant chemistry between the leads and the endless cameos. The main criticisms focused on a somewhat generic multiversal plot and messy CGI in some action sequences.'
),
(
    'Inside Out 2', 2024, 'Animation / Family', '1h 36m', 'Kelsey Mann', 
    'Teenager Riley''s mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions!',
    'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&w=600&q=80',
    8.8, 85, 11, 4,
    'An incredibly emotional and highly relatable sequel that resonates with both kids and adults. The introduction of Anxiety is widely praised, with viewers calling the panic attack scene highly accurate and moving.'
),
(
    'Furiosa: A Mad Max Saga', 2024, 'Action / Sci-Fi', '2h 28m', 'George Miller', 
    'The origin story of renegade warrior Furiosa before her alliance with Mad Max.',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=600&q=80',
    7.9, 68, 20, 12,
    'Viewers praised the stellar action sequences, world-building, and performances. However, many felt it did not quite live up to the sheer non-stop kinetic energy of Fury Road, noting some noticeable green screen effects.'
),
(
    'Civil War', 2024, 'Action / Thriller', '1h 49m', 'Alex Garland', 
    'A journey across a dystopian future America, following a team of military-embedded journalists as they race to reach DC before rebel factions descend.',
    'https://images.unsplash.com/photo-1513151233558-d860c5398176?auto=format&fit=crop&w=600&q=80',
    7.7, 60, 25, 15,
    'Audiences praised the intense, heart-stopping sound design and the stressful, realistic atmosphere. Major criticisms pointed to the movie''s deliberate avoidance of specific political context, which left some feeling disengaged.'
),
(
    'Challengers', 2024, 'Drama / Romance', '2h 11m', 'Luca Guadagnino', 
    'Three players who knew each other when they were teenagers compete in a tennis tournament to be the world-famous grand slam winner.',
    'https://images.unsplash.com/photo-1622279457486-62dcc4a4b1dc?auto=format&fit=crop&w=600&q=80',
    8.3, 76, 17, 7,
    'Highly praised for its electric, pulsating soundtrack and intense, camera-shifting tennis sequences. The complex relationship dynamic kept audiences hooked, though a few found the aggressive editing and flashbacks dizzying.'
),
(
    'Godzilla x Kong: The New Empire', 2024, 'Action / Sci-Fi', '1h 55m', 'Adam Wingard', 
    'Two ancient titans, Godzilla and Kong, clash in an epic battle as humans unravel their intertwined origins.',
    'https://images.unsplash.com/photo-1568832359672-e36cf5d74f54?auto=format&fit=crop&w=600&q=80',
    7.2, 58, 28, 14,
    'Audiences agreed this is a fun, brainless popcorn movie with great monster fights. However, many heavily criticized the weak human subplots and the overly ridiculous sci-fi explanations.'
),
(
    'A Quiet Place: Day One', 2024, 'Horror / Sci-Fi', '1h 39m', 'Michael Sarnoski', 
    'Experience the day the world went silent in this tense horror-thriller set in New York City.',
    'https://images.unsplash.com/photo-1509248961158-e54f6934749c?auto=format&fit=crop&w=600&q=80',
    7.8, 70, 21, 9,
    'Viewers loved the emotional focus on the two lead characters and their cat, finding it a refreshing change of pace for the franchise. Some horror purists, however, wanted more traditional jump scares and creature action.'
),
(
    'Twisters', 2024, 'Action / Adventure', '2h 2m', 'Lee Isaac Chung', 
    'An update to the 1996 film tracking a new generation of storm chasers pushing the limits of technology.',
    'https://images.unsplash.com/photo-1461088945293-0c17689e48ac?auto=format&fit=crop&w=600&q=80',
    8.0, 75, 18, 7,
    'A massive, nostalgic fun-ride. The chemistry between the leads and the incredibly intense tornado sequences were highly praised. Critics in the audience noted the plot beat-for-beat mirrors the original movie.'
),
(
    'Alien: Romulus', 2024, 'Horror / Sci-Fi', '1h 59m', 'Fede Álvarez', 
    'While scavenging the deep ends of a derelict space station, a group of young space colonizers come face to face with the most terrifying life force in the universe.',
    'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?auto=format&fit=crop&w=600&q=80',
    8.1, 74, 16, 10,
    'Praised for its incredible practical effects, intense horror roots, and stellar set designs. Some fans complained about a controversial CGI character recreation and an over-reliance on legacy franchise easter eggs.'
),
(
    'Beetlejuice Beetlejuice', 2024, 'Comedy / Fantasy', '1h 44m', 'Tim Burton', 
    'After an unexpected family tragedy, three generations of the Deetz family return home to Winter River, where Beetlejuice makes his chaotic return.',
    'https://images.unsplash.com/photo-1508341591423-4347099e1f19?auto=format&fit=crop&w=600&q=80',
    7.4, 62, 26, 12,
    'Audiences loved the return to Tim Burton''s classic wacky, dark, practical-effect style. Many felt the narrative had too many competing subplots, leaving several characters feeling underdeveloped.'
),
(
    'Gladiator II', 2024, 'Action / Drama', '2h 28m', 'Ridley Scott', 
    'Years after witnessing the death of the revered hero Maximus, Lucius is forced to enter the Colosseum after his home is conquered by tyrannical emperors.',
    'https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?auto=format&fit=crop&w=600&q=80',
    7.8, 69, 21, 10,
    'Audiences praised the grand scale of the Colosseum battles and a highly charismatic villainous performance by Denzel Washington. Many noted it does not quite reach the emotional heights or poetic nature of the original classic.'
),
(
    'Wicked', 2024, 'Fantasy / Musical', '2h 40m', 'Jon M. Chu', 
    'The untold story of the witches of Oz, focusing on Elphaba''s journey before she becomes the Wicked Witch.',
    'https://images.unsplash.com/photo-1514306191717-452ec28c7814?auto=format&fit=crop&w=600&q=80',
    8.9, 87, 9, 4,
    'A stunningly realized musical adaptation. Viewers raved about the powerhouse vocal performances and the highly detailed production sets. Some felt the runtime was slightly padded to justify splitting the show into two movies.'
),
(
    'Kingdom of the Planet of the Apes', 2024, 'Action / Sci-Fi', '2h 25m', 'Wes Ball', 
    'Many years after the reign of Caesar, a young ape goes on a journey that will lead him to question everything he''s been taught about the past.',
    'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=600&q=80',
    7.9, 70, 22, 8,
    'Praise was aimed at the flawless CGI and motion capture, with a compelling leading protagonist. Critics felt the pacing slowed down significantly during the middle act setup.'
),
(
    'Despicable Me 4', 2024, 'Animation / Comedy', '1h 34m', 'Chris Renaud', 
    'Gru and his family welcome a new member to the family, Gru Jr., who is intent on tormenting his dad.',
    'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&w=600&q=80',
    6.8, 48, 38, 14,
    'Fun, colorful, and packed with Minion shenanigans that had kids laughing non-stop. Older viewers, however, felt the franchise is running extremely thin on fresh narrative ideas.'
),

-- =========================================================================
-- !!! MODERN BLOCKBUSTERS & CULTURAL PHENOMENA !!! (Movies 46-70)
-- =========================================================================
(
    'Oppenheimer', 2023, 'Biography / Drama', '3h 0m', 'Christopher Nolan', 
    'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.',
    'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=600&q=80',
    9.2, 91, 6, 3,
    'An absolute cinematic triumph. Audiences were spellbound by the explosive sound design, rapid-fire editing, and powerhouse leading performance. The only complaints focused on the dense, political third-act hearings.'
),
(
    'Barbie', 2023, 'Comedy / Fantasy', '1h 54m', 'Greta Gerwig', 
    'Stereotypical Barbie experiences a sudden existential crisis, leading her on a journey of discovery from Barbieland to the Real World.',
    'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?auto=format&fit=crop&w=600&q=80',
    8.5, 78, 14, 8,
    'A delightfully colorful, hilarious, and surprisingly deep social satire. Audiences loved the catchy musical numbers and Ryan Gosling''s scene-stealing performance. Some felt the third-act pacing got a little disorganized.'
),
(
    'Spider-Man: Across the Spider-Verse', 2023, 'Animation / Action', '2h 20m', 'Joaquim Dos Santos', 
    'Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its very existence.',
    'https://images.unsplash.com/photo-1608889175123-8ec330b86f84?auto=format&fit=crop&w=600&q=80',
    9.3, 92, 5, 3,
    'An absolute visual feast that pushes the boundaries of what animation can achieve. Viewers loved the emotional growth of the characters and the jaw-dropping soundtrack. The only minor frustration was the abrupt cliffhanger ending.'
),
(
    'Interstellar', 2014, 'Sci-Fi / Adventure', '2h 49m', 'Christopher Nolan', 
    'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.',
    'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=600&q=80',
    8.9, 85, 10, 5,
    'Deeply emotional and grand in scale. The soundtrack by Hans Zimmer is widely considered one of the greatest of all time. Some audience members found the complex physics-heavy ending hard to follow on first watch.'
),
(
    'The Dark Knight', 2008, 'Action / Crime', '2h 32m', 'Christopher Nolan', 
    'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
    'https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?auto=format&fit=crop&w=600&q=80',
    9.5, 94, 4, 2,
    'Widely considered the greatest comic book film of all time. Heath Ledger''s legendary performance as the Joker is universally praised. A flawlessly paced, gritty crime epic that set a new standard for cinema.'
),
(
    'Everything Everywhere All at Once', 2022, 'Sci-Fi / Comedy', '2h 19m', 'Daniel Kwan, Daniel Scheinert', 
    'A middle-aged Chinese immigrant is swept up into an insane adventure in which she alone can save existence by exploring other universes.',
    'https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?auto=format&fit=crop&w=600&q=80',
    8.7, 81, 12, 7,
    'A chaotic, incredibly original masterpiece packed with humor, martial arts, and profound emotional depth. Some viewers found the chaotic pacing of the first hour a bit overwhelming to keep up with.'
),
(
    'Top Gun: Maverick', 2022, 'Action / Drama', '2h 10m', 'Joseph Kosinski', 
    'After thirty years, Maverick is still pushing the envelope as a top naval aviator, training a new detachment of graduates for a dangerous specialized mission.',
    'https://images.unsplash.com/photo-1519074002996-a69e7ac46a42?auto=format&fit=crop&w=600&q=80',
    9.1, 89, 8, 3,
    'The ultimate cinematic adrenaline rush. Audiences raved about the real cockpit camera footage and intense aerial stunts. A textbook example of how to make a legacy sequel that surpasses the original.'
),
(
    'Inception', 2010, 'Sci-Fi / Action', '2h 28m', 'Christopher Nolan', 
    'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=600&q=80',
    8.8, 83, 12, 5,
    'Brilliant, mind-bending sci-fi action. The visual effects and gravity-defying hotel hallway fight scene remain iconic. Critics in the audience found the heavy exposition dumps in the first hour a bit tedious.'
),
(
    'Spider-Man: No Way Home', 2021, 'Action / Sci-Fi', '2h 28m', 'Jon Watts', 
    'With Spider-Man''s identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear.',
    'https://images.unsplash.com/photo-1635805737707-575885ab0820?auto=format&fit=crop&w=600&q=80',
    8.8, 84, 11, 5,
    'A massive celebration of Spider-Man cinema history. The audience reactions to the massive crossover moments remain legendary. Some pointed out the writing relied heavily on nostalgia over logical plotting.'
),
(
    'Avengers: Endgame', 2019, 'Action / Sci-Fi', '3h 1m', 'Anthony and Joe Russo', 
    'After the devastating events of Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more to reverse Thanos'' actions.',
    'https://images.unsplash.com/photo-1569003339405-ea396a5a8a90?auto=format&fit=crop&w=600&q=80',
    9.2, 90, 7, 3,
    'An incredibly satisfying culmination of over a decade of storytelling. The final battle sequence is universally beloved, though some fans found the time travel logic a bit inconsistent.'
),
(
    'The Matrix', 1999, 'Sci-Fi / Action', '2h 16m', 'Lana Wachowski, Lilly Wachowski', 
    'When a beautiful stranger leads computer hacker Neo to a forbidding underworld, he discovers the shocking truth--the life he knows is the elaborate deception of an evil cyber-intelligence.',
    'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=600&q=80',
    9.3, 91, 6, 3,
    'A revolutionary action classic that forever changed the landscape of cinema and visual effects. The philosophy and "bullet time" sequences are legendary, and viewers still find it incredibly cool.'
),
(
    'Pulp Fiction', 1994, 'Crime / Drama', '2h 34m', 'Quentin Tarantino', 
    'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
    'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?auto=format&fit=crop&w=600&q=80',
    9.2, 89, 7, 4,
    'Famed for its incredible, snappy dialogue, non-linear storyline, and massive pop culture impact. Critics in the audience noted the intense violence and non-stop language may not be for sensitive viewers.'
),
(
    'Whiplash', 2014, 'Drama / Music', '1h 47m', 'Damien Chazelle', 
    'A promising young drummer enrolls at a cut-throat music conservatory where his dreams of greatness are mentored by an instructor who will stop at nothing to realize a student''s potential.',
    'https://images.unsplash.com/photo-1511192336575-5a79af67a629?auto=format&fit=crop&w=600&q=80',
    9.1, 89, 8, 3,
    'An incredibly stressful, high-intensity masterpiece. Audiences were on the edge of their seats, praising the intense acting battles and the jaw-dropping drum finale. Some noted the teaching methods depicted are deeply toxic.'
),
(
    'Parasite', 2019, 'Thriller / Drama', '2h 12m', 'Bong Joon Ho', 
    'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.',
    'https://images.unsplash.com/photo-1535498730771-e735b998cd64?auto=format&fit=crop&w=600&q=80',
    9.3, 91, 6, 3,
    'A flawless, genre-bending masterpiece that seamlessly shifts from a dark comedy into an incredibly tense thriller. Universally praised for its social commentary, set design, and shocking plot twists.'
),
(
    'Fight Club', 1999, 'Drama / Thriller', '2h 19m', 'David Fincher', 
    'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into much more.',
    'https://images.unsplash.com/photo-1485846234645-a62644f84728?auto=format&fit=crop&w=600&q=80',
    8.8, 80, 13, 7,
    'Audiences loved the gritty cinematography, the psychological tension, and one of the most famous twist endings in cinema history. Some viewers found its cynical worldview and aggression a bit dated.'
),
(
    'The Lion King', 1994, 'Animation / Family', '1h 28m', 'Roger Allers, Rob Minkoff', 
    'A young lion prince flees his kingdom after the murder of his father, only to learn the true meaning of responsibility and bravery.',
    'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=600&q=80',
    9.4, 93, 5, 2,
    'A timeless masterpiece. Audiences of all generations love the iconic soundtrack, unforgettable characters, and beautiful hand-drawn animation. It remains the gold standard of animated cinema.'
),
(
    'Spider-Man: Into the Spider-Verse', 2018, 'Animation / Action', '1h 57m', 'Bob Persichetti', 
    'Teen Miles Morales becomes the Spider-Man of his universe and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.',
    'https://images.unsplash.com/photo-1635805737707-575885ab0820?auto=format&fit=crop&w=600&q=80',
    9.2, 90, 7, 3,
    'A groundbreaking animated classic that completely changed the industry. Audiences raved about the incredible comic-book art style, brilliant soundtrack, and deeply emotional script.'
),
(
    'Get Out', 2017, 'Horror / Thriller', '1h 44m', 'Jordan Peele', 
    'A young African-American visits his white girlfriend''s parents for the weekend, where his simmering uneasiness about their reception eventually reaches a boiling point.',
    'https://images.unsplash.com/photo-1509248961158-e54f6934749c?auto=format&fit=crop&w=600&q=80',
    9.0, 88, 9, 3,
    'Jordan Peele’s directorial debut is a brilliant, highly stressful social thriller. Audiences praised the sharp social commentary, fantastic comedic relief, and perfect pacing.'
),
(
    'Knives Out', 2019, 'Comedy / Mystery', '2h 10m', 'Rian Johnson', 
    'A detective investigates the death of the patriarch of an eccentric, combative family.',
    'https://images.unsplash.com/photo-1513151233558-d860c5398176?auto=format&fit=crop&w=600&q=80',
    8.4, 79, 15, 6,
    'An incredibly fun, modern whodunnit. Audiences loved the star-studded cast, the cozy autumn atmosphere, and a highly satisfying puzzle box plot that keeps you guessing until the very end.'
),
(
    'La La Land', 2016, 'Drama / Romance', '2h 8m', 'Damien Chazelle', 
    'While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future.',
    'https://images.unsplash.com/photo-1514306191717-452ec28c7814?auto=format&fit=crop&w=600&q=80',
    8.9, 84, 11, 5,
    'A vibrant, visually gorgeous musical valentine to Hollywood. Viewers loved the electric opening number and the bittersweet, highly realistic ending. A few non-musical fans found the transitions a bit jarring.'
),
(
    'The Grand Budapest Hotel', 2014, 'Comedy / Drama', '1h 39m', 'Wes Anderson', 
    'A writer relates his adventures at a renowned European resort hotel between the first and second World Wars.',
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=600&q=80',
    8.7, 82, 13, 5,
    'An absolute joy to watch. Wes Anderson’s signature symmetrical cinematography, candy-colored palette, and whimsical dialogue are at their absolute peak here. Some felt the fast-paced style made the emotional beats fly by too quickly.'
),
(
    'Dunkirk', 2017, 'Action / Drama', '1h 46m', 'Christopher Nolan', 
    'Allied soldiers from Belgium, the British Commonwealth and Empire, and France are surrounded by the German Army and evacuated during a fierce battle in World War II.',
    'https://images.unsplash.com/photo-1501535033-a598910b3990?auto=format&fit=crop&w=600&q=80',
    8.3, 75, 17, 8,
    'A masterclass in non-stop, ticking-clock cinematic suspense. Viewers loved the sweeping visuals and minimal dialogue approach, though some found the three interlocking timelines a bit confusing on first watch.'
),
(
    'The Lord of the Rings: The Fellowship of the Ring', 2001, 'Fantasy / Adventure', '2h 58m', 'Peter Jackson', 
    'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.',
    'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=600&q=80',
    9.5, 94, 4, 2,
    'A perfect fantasy epic. Peter Jackson’s sweeping New Zealand landscapes, stellar practical effects, and legendary cast established Middle-earth as one of cinema''s greatest achievements.'
),
(
    'The Lord of the Rings: The Return of the King', 2003, 'Fantasy / Adventure', '3h 21m', 'Peter Jackson', 
    'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.',
    'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=600&q=80',
    9.6, 95, 3, 2,
    'The grand coronation of fantasy cinema. Winner of 11 Academy Awards, this film delivers some of the most emotionally satisfying battles and conclusions ever captured. The multiple endings were noted as long but earned.'
),
(
    'Gladiator', 2000, 'Action / Drama', '2h 35m', 'Ridley Scott', 
    'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.',
    'https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?auto=format&fit=crop&w=600&q=80',
    9.1, 88, 9, 3,
    'A spectacular modern epic. Russell Crowe’s commanding, emotional performance and Hans Zimmer’s sweeping score hold up perfectly. Some history buffs note a few creative liberties were taken with Roman politics.'
),
(
    'Spider-Man 2', 2004, 'Action / Sci-Fi', '2h 7m', 'Sam Raimi', 
    'Peter Parker is beset with troubles in his failing personal life as he battles a brilliant scientist named Doctor Octopus.',
    'https://images.unsplash.com/photo-1635805737707-575885ab0820?auto=format&fit=crop&w=600&q=80',
    9.0, 89, 8, 3,
    'Still considered a gold standard of the superhero genre. Raimi balances Peter Parker''s tragic personal struggles with stellar action sequences, highlighted by the legendary train battle scene.'
),
(
    'Star Wars: Episode V - The Empire Strikes Back', 1980, 'Sci-Fi / Adventure', '2h 4m', 'Irvin Kershner', 
    'After the Rebels are brutally overpowered by the Empire on the ice planet Hoth, Luke Skywalker begins Jedi training with Yoda.',
    'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=600&q=80',
    9.5, 93, 5, 2,
    'The absolute pinnacle of the Star Wars franchise. Audiences love the darker tone, the rich training sequences, and one of the most famous twists in movie history. An undisputed masterpiece.'
),
(
    'Jurassic Park', 1993, 'Sci-Fi / Adventure', '2h 7m', 'Steven Spielberg', 
    'A pragmatic paleontologist touring an almost complete theme park on an island in Central America is tasked with protecting two kids after a power failure releases the park''s cloned dinosaurs.',
    'https://images.unsplash.com/photo-1560114928-40f1f1eb26a0?auto=format&fit=crop&w=600&q=80',
    9.3, 91, 7, 2,
    'Spielberg’s blend of groundbreaking CGI and incredible practical animatronics still looks superior to most modern blockbusters. Highly tense, perfectly paced, and deeply nostalgic for all ages.'
),
(
    'Titanic', 1997, 'Drama / Romance', '3h 14m', 'James Cameron', 
    'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=600&q=80',
    9.0, 84, 11, 5,
    'An unmatched cinematic disaster-romance spectacle. James Cameron’s scale of the ship''s sinking combined with the central love story captured the world. Some found the runtime demanding, but agreed the third act is unforgettable.'
),
(
    'Inglourious Basterds', 2009, 'Action / Drama', '2h 33m', 'Quentin Tarantino', 
    'In Nazi-occupied France during World War II, a plan to assassinate Adolf Hitler by a group of Jewish U.S. soldiers coincides with a theater owner''s vengeful plans.',
    'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?auto=format&fit=crop&w=600&q=80',
    9.1, 87, 10, 3,
    'Famed for its masterfully written, incredibly tense conversational scenes (especially the opening farmhouse scene). Christoph Waltz’s iconic villainous performance is universally praised.'
),
(
    'The Wolf of Wall Street', 2013, 'Biography / Comedy', '3h 0m', 'Martin Scorsese', 
    'Based on the true story of Jordan Belfort, from his rise to a wealthy stockbroker living the high life to his fall involving crime, corruption and the federal government.',
    'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?auto=format&fit=crop&w=600&q=80',
    8.9, 83, 11, 6,
    'A wildly chaotic, hilariously energetic look at greed and excess. DiCaprio delivers a career-high comedic performance. Some viewers felt the three-hour runtime repeats similar party beats a few too many times.'
),
(
    'Spirited Away', 2001, 'Animation / Fantasy', '2h 5m', 'Hayao Miyazaki', 
    'During her family''s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.',
    'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=600&q=80',
    9.4, 93, 5, 2,
    'Miyazaki’s hand-drawn magnum opus is a stunning, highly imaginative work of art. Audiences of all ages are swept away by the magical atmosphere, beautiful score, and rich coming-of-age story.'
),
(
    'No Country for Old Men', 2007, 'Crime / Thriller', '2h 2m', 'Joel Coen, Ethan Coen', 
    'Violence and mayhem ensue after a hunter stumbles upon a drug deal gone wrong and more than two million dollars in cash near the Rio Grande.',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=600&q=80',
    9.2, 89, 8, 3,
    'A beautifully shot, intensely quiet thriller that grips you without a traditional musical score. Javier Bardem’s chilling Anton Chigurh is legendary. The sudden ending remains a topic of massive debate.'
),
(
    'Ratatouille', 2007, 'Animation / Comedy', '1h 51m', 'Brad Bird', 
    'A rat who can cook makes an unusual alliance with a young kitchen worker at a famous Paris restaurant.',
    'https://images.unsplash.com/photo-1556910103-1c02745aae4d?auto=format&fit=crop&w=600&q=80',
    9.0, 89, 9, 2,
    'A delightfully written, gorgeously animated love letter to food, art, and passion. Highly praised for its humor and the moving climax involving the critical food review.'
),
(
    'The Prestige', 2006, 'Drama / Mystery', '2h 10m', 'Christopher Nolan', 
    'After a tragic accident, two stage magicians in 1890s London engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other.',
    'https://images.unsplash.com/photo-1511192336575-5a79af67a629?auto=format&fit=crop&w=600&q=80',
    8.9, 85, 11, 4,
    'A brilliant, twisty puzzle-box film about obsession. Nolan structures the movie exactly like a magic trick, leaving audiences completely shocked by the dual final reveals.'
),
(
    'Shutter Island', 2010, 'Mystery / Thriller', '2h 18m', 'Martin Scorsese', 
    'In 1954, a U.S. Marshal investigates the disappearance of a murderer who escaped from a hospital for the criminally insane.',
    'https://images.unsplash.com/photo-1505635552518-3448ff116af3?auto=format&fit=crop&w=600&q=80',
    8.4, 76, 17, 7,
    'Deeply atmospheric, creepy, and psychological. Scorsese sets up a brilliant, rain-soaked sense of dread, leading to one of the most famous and devastating twist endings of the 2010s.'
),
(
    'Scott Pilgrim vs. the World', 2010, 'Action / Comedy', '1h 52m', 'Edgar Wright', 
    'In a Toronto garage-rock band, Scott Pilgrim must defeat his new girlfriend''s seven evil exes in order to win her heart.',
    'https://images.unsplash.com/photo-1608889175123-8ec330b86f84?auto=format&fit=crop&w=600&q=80',
    8.3, 73, 18, 9,
    'A hyper-stylized, fast-paced cult classic. Edgar Wright’s editing, video game visual effects, and dynamic musical sequences are a blast, though some found Scott’s character a bit difficult to root for.'
),
(
    'Mad Max: Fury Road', 2015, 'Action / Sci-Fi', '2h 0m', 'George Miller', 
    'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search for her homeland with the aid of a group of female prisoners, a psychotic worshiper, and a drifter named Max.',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=600&q=80',
    9.3, 91, 6, 3,
    'An absolute action milestone. The non-stop practical stunts, intense desert color palette, and incredible pacing make this a masterclass in visual storytelling.'
),
(
    'Blade Runner 2049', 2017, 'Sci-Fi / Mystery', '2h 44m', 'Denis Villeneuve', 
    'A new blade runner, LAPD Officer K, unearths a long-buried secret that has the potential to plunge what''s left of society into chaos.',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=600&q=80',
    8.7, 81, 13, 6,
    'Visually spectacular. Roger Deakins’ Oscar-winning cinematography and the deep philosophical expansion of the original story make this a rare sequel that matches its predecessor, despite a very deliberate, slow-burn pace.'
),
(
    'The Trueman Show', 1998, 'Comedy / Drama', '1h 43m', 'Peter Weir', 
    'An insurance salesman discovers his entire life is actually a constructed reality television show, telecast 24/7 to a global audience.',
    'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=600&q=80',
    9.2, 90, 7, 3,
    'Prophetic, brilliant, and deeply emotional. Jim Carrey delivers an outstanding dramatic-comedy performance in a movie that predicted our modern obsession with reality media and streaming culture.'
);