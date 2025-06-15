-- lessonPlan Database

-- CREATE DATABASE
CREATE DATABASE lessonPlan;
USE lessonPlan;

-- CREATE TABLES

-- -- -- Lesson Concept
CREATE TABLE lesson (
    lessonPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    rationale VARCHAR(1000) NOT NULL
);

-- -- -- Subject
CREATE TABLE subject (
    subjectPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    grade INT NOT NULL
);

-- Lesson-Subject Junction
CREATE TABLE lessonSubject (
    lessonSubjectPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonFK INT NOT NULL,
    subjectFK INT NOT NULL,
    FOREIGN KEY (lessonFK) REFERENCES lesson(lessonPK),
    FOREIGN KEY (subjectFK) REFERENCES subject(subjectPK)
);

-- -- -- Skill
CREATE TABLE skill (
    skillPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NULL,
    parentSkillFK INT NULL,
    FOREIGN KEY (parentSkillFK) REFERENCES skill(skillPK)
);

-- Lesson-Skill Junction
CREATE TABLE lessonSkill (
    lessonSkillPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonFK INT NOT NULL,
    skillFK INT NOT NULL,
    FOREIGN KEY (lessonFK) REFERENCES lesson(lessonPK),
    FOREIGN KEY (skillFK) REFERENCES skill(skillPK)
);

-- -- -- Unit
CREATE TABLE unit (
    unitPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    rationale VARCHAR(1000) NOT NULL,
    subjectFK INT NOT NULL,
    parentFK INT NULL,
    FOREIGN KEY (parentFK) REFERENCES unit(unitPK),
    FOREIGN KEY (subjectFK) REFERENCES subject(subjectPK)
);

-- Lesson-Unit Junction
CREATE TABLE lessonUnit (
    lessonUnitPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonFK INT NOT NULL,
    unitFK INT NOT NULL,
    FOREIGN KEY (lessonFK) REFERENCES lesson(lessonPK),
    FOREIGN KEY (unitFK) REFERENCES unit(unitPK)
);

-- -- -- Objective
CREATE TABLE objective (
    objectivePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(1000) NOT NULL
);

-- Lesson-Objective Junction
CREATE TABLE lessonObjective (
    lessonObjectivePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonFK INT NOT NULL,
    objectiveFK INT NOT NULL,
    FOREIGN KEY (lessonFK) REFERENCES lesson(lessonPK),
    FOREIGN KEY (objectiveFK) REFERENCES objective(objectivePK)
);

-- -- -- Theme
CREATE TABLE theme (
    themePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Lesson-Theme Junction
CREATE TABLE lessonTheme (
    lessonThemePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonFK INT NOT NULL,
    themeFK INT NOT NULL,
    FOREIGN KEY (lessonFK) REFERENCES lesson(lessonPK),
    FOREIGN KEY (themeFK) REFERENCES theme(themePK)
);

-- -- -- Differentiation
CREATE TABLE differentiation (
    differentiationPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    strategy VARCHAR(255) NOT NULL
);

-- Lesson-Differentiation Junction
CREATE TABLE lessonDifferentiation (
    lessonDifferentiationPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonFK INT NOT NULL,
    differentiationFK INT NOT NULL,
    FOREIGN KEY (lessonFK) REFERENCES lesson(lessonPK),
    FOREIGN KEY (differentiationFK) REFERENCES differentiation(differentiationPK)
);

-- -- -- Material
CREATE TABLE material (
    materialPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    parentFK INT NULL,
    FOREIGN KEY (parentFK) REFERENCES material(materialPK)
);

-- Lesson-Material Junction
CREATE TABLE lessonMaterial (
    lessonMaterialPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonFK INT NOT NULL,
    materialFK INT NOT NULL,
    FOREIGN KEY (lessonFK) REFERENCES lesson(lessonPK),
    FOREIGN KEY (materialFK) REFERENCES material(materialPK)
);

-- -- -- Assessment
CREATE TABLE assessment (
    assessmentPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    parentFK INT NULL,
    FOREIGN KEY (parentFK) REFERENCES assessment(assessmentPK)

);

-- Lesson-Assessment Junction
CREATE TABLE lessonAssessment (
    lessonAssessmentPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonFK INT NOT NULL,
    assessmentFK INT NOT NULL,
    FOREIGN KEY (assessmentFK) REFERENCES assessment(assessmentPK),
    FOREIGN KEY (lessonFK) REFERENCES lesson(lessonPK)
);

-- LessonAssessment-LessonSkill Junction
CREATE TABLE lessonAssessmentSkill (
    lessonAssessmentSkillPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonAssessmentFK INT NOT NULL,
    lessonSkillFK INT NOT NULL,
    FOREIGN KEY (lessonAssessmentFK) REFERENCES lessonAssessment(lessonAssessmentPK),
    FOREIGN KEY (lessonSkillFK) REFERENCES lessonSkill(lessonSkillPK)
);

-- -- -- Text
CREATE TABLE text (
    textPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL
);

-- Name
CREATE TABLE name (
    namePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Author
CREATE TABLE author (
    authorPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(255) NOT NULL
);

-- Author-Name Junction
CREATE TABLE authorName (
    authorNamePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    authorFK INT NOT NULL,
    nameFK INT NOT NULL,
    position INT NOT NULL,
    FOREIGN KEY (authorFK) REFERENCES author(authorPK),
    FOREIGN KEY (nameFK) REFERENCES name(namePK)
);

-- Text-Author Junction
CREATE TABLE textAuthor (
    textAuthorPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    textFK INT NOT NULL,
    authorFK INT NOT NULL,
    FOREIGN KEY (textFK) REFERENCES text(textPK),
    FOREIGN KEY (authorFK) REFERENCES author(authorPK)
);

-- Lesson-Text Junction
CREATE TABLE lessonText (
    lessonTextPK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonFK INT NOT NULL,
    textFK INT NOT NULL,
    FOREIGN KEY (lessonFK) REFERENCES lesson(lessonPK),
    FOREIGN KEY (textFK) REFERENCES text(textPK)
);

-- -- -- Time
CREATE TABLE timeType (
    timeTypePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    minuteValue INT NOT NULL
);

-- -- -- LessonUnit-Time Junction
-- Each row is a single lesson-unit taught for a duration of time
CREATE TABLE lessonUnitConcrete (
    lessonUnitConcretePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonUnitFK INT NOT NULL,
    duration INT NOT NULL,
    timeTypeFK INT NOT NULL,
    FOREIGN KEY (lessonUnitFK) REFERENCES lessonUnit(lessonUnitPK),
    FOREIGN KEY (timeTypeFK) REFERENCES timeType(timeTypePK)
);

-- -- -- LessonUnit-UnitConcrete
-- Each row is a lesson taught a specific date, as part of some unit
CREATE TABLE lessonConcrete (
    lessonConcretePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonDate DATE NOT NULL,
    lessonUnitConcreteFK INT NOT NULL,
    lessonDay INT NOT NULL,
    lessonPATH VARCHAR(255) NOT NULL,
    FOREIGN KEY (lessonUnitConcreteFK) REFERENCES lessonUnitConcrete(lessonUnitConcretePK)
);

-- -- -- Material Concrete
-- Each row is a tangible material used for a specific lesson
CREATE TABLE materialConcrete (
    materialConcretePK INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lessonMaterialFK INT NOT NULL,
    lessonConcreteFK INT NOT NULL,
    lessonAssessmentFK INT NOT NULL,
    lessonDifferentiationFK INT NOT NULL,
    materialPATH VARCHAR(1000) NOT NULL,
    FOREIGN KEY (lessonConcreteFK) REFERENCES lessonConcrete(lessonConcretePK),
    FOREIGN KEY (lessonAssessmentFK) REFERENCES lessonAssessment(lessonAssessmentPK),
    FOREIGN KEY (lessonDifferentiationFK) REFERENCES lessonDifferentiation(lessonDifferentiationPK),
    FOREIGN KEY (lessonMaterialFK) REFERENCES lessonMaterial(lessonMaterialPK)
);

-- FILL VALUES --------

INSERT INTO lesson (title, description, rationale) VALUES
    ('Pericles Funeral Oration','Students read Pericles Funeral Oration and analyze the rhetorical situation','To appreciate the rigor and beauty of classical rhetoric and understand the tools used'),
    ('Henry V Speech','Students read Henry V war speech and analyze the line of reasoning','To appreciate Shakespeare, understand a variety of rhetorical contexts, and practice line of reasoning'),
    ('MacArthur Westpoint Speech', 'Students read MacArthurs address to westpoint and analyze the rhetorical choices, line of reasoning, and style', 'To understand eternal human realities, to be able to describe rhetorical choices'),
    ('Dust Bowl Photographs', 'Students look at and evaluate media from the Dust Bowl Era', 'To provide context for American Fiction from the Great Depression, to humanize the past'),
    ('Harlem Close Reading', 'Students read, annotate, and answer prompts for Langston Hughes Harlem', 'To provide context for the Harlem Renaissance, to engage with poetry'),
    ('Poetry: Abcedarian', 'Students write an abcedarian after seeing 2 examples', 'To demonstrate the variety of poetry in the world');

INSERT INTO subject(name, grade) VALUES
    ('AP Language and Composition', 11),
    ('English', 9);

INSERT INTO lessonSubject(lessonFK, subjectFK) VALUES
    (1,1),
    (2,1),
    (3,1),
    (4,2),
    (5,2),
    (6,2);

INSERT INTO skill (name, description, parentSkillFK) VALUES
    ('AP', 'Advanced Placement', NULL),
    ('CCSS', 'Common Core State Standards', NULL),
    ('APLANG', 'AP Language and Composition', 1),
    ('CCSS.ELA', 'Common Core State Standards English Language Arts', 2),
    ('RL', 'Reading Literature', 4),
    ('RI', 'Reading Informational Text', 4),
    ('SL', 'Speaking and Listening', 4),
    ('W', 'Writing', 4),
    ('L', 'Language', 4),
    ('9-10.RL', '9th and 10th Grade Reading Literature', 5),
    ('9-10.RI', '9th and 10th Grade Reading Informational Text', 6),
    ('9-10.SL', '9th and 10th Grade Speaking and Listening', 7),
    ('9-10.W', '9th and 10th Grade Writing', 8),
    ('9-10.L', '9th and 10th Grade Language', 9),
    ('RHS', 'Rhetorical Situation', 3),
    ('CLE', 'Claims and Evidence', 3),
    ('REO', 'Reasoning and Organization', 3),
    ('STY', 'Style', 3),
    ('9-10.RL.4', 'Determine the figurative or connotative meaning(s) of words and phrases as they are used in a text; analyze the impact of words with multiple meanings, as well as symbols or metaphors that extend throughout a text and shape its meaning.', 10),
    ('9-10.L.4a', 'Use context (e.g., the overall meaning of a sentence, paragraph, or text; a word’s position or function in a sentence) as a clue to the meaning of a word or phrase.', 14),
    ('9-10.RL.1', 'Cite strong and thorough textual evidence to support analysis of what a text states explicitly as well as inferences drawn from the text.',10),
    ('9-10.RI.1', 'Cite strong and thorough textual evidence to support analysis of what a text states explicitly as well as inferences drawn from the text.', 11),
    ('9-10.RI.9', 'Analyze seminal documents of historical and literary significance, including how they address related themes and concepts.', 11),
    ('9-10.SL.1', 'Initiate and participate effectively in a range of collaborative discussions (one-on-one, in groups, and teacher-led) with diverse partners on grades 9–10 topics, texts, and issues, building on others’ ideas and expressing their own clearly and persuasively', 12),
    ('9-10.W.4', 'Produce clear and coherent writing in which the development, organization, and style are appropriate to task, purpose, and audience', 13),
    ('9-10.L.5','Demonstrate understanding of figurative language, word relationships, and nuances in word meanings.', 14),
    ('CLE.3.A', 'Identify and explain claims and evidence within an argument', 16),
    ('RHS.1.A', 'Identify and describe components of the rhetorical situation: the exigence, audience, writer, purpose, context, and message.',15),
    ('REO.5.A', 'Describe the line of reasoning and explain whether it supports an argument’s overarching thesis', 17),
    ('STY.7.A', 'Explain how word choice, comparisons, and syntax contribute to the specific tone or style of a text.', 18),
    ('REO.6.A', 'Develop a line of reasoning and commentary that explains it throughout an argument.',17),
    ('REO.6.C', 'Use appropriate methods of development to advance an argument.', 17),
    ('CLE.4.B', 'Write a thesis statement that requires proof or defense and that may preview the structure of the argument.',16);

INSERT INTO lessonSkill (lessonFK, skillFK) VALUES
    (1,28),
    (1,30),
    (1,27),
    (2,31),
    (2,32),
    (2,28),
    (2,29),
    (3,29),
    (3,28),
    (3,33),
    (3,31),
    (4,22),
    (4,23),
    (4,24),
    (5,19),
    (5,20),
    (5,21),
    (5,26),
    (6,26),
    (6,25),
    (3, 27),
    (3, 30),
    (3, 32);

INSERT INTO unit (name, description, rationale, subjectFK, parentFK) VALUES
    ('Truth and War', 'Students will read famous speeches on War, as well as read various Texts on the nature of Truth. These two concepts will guide a thematic understanding of how situations shape rhetoric and the creation or understanding of truth','To appreicate the complexity in human speech and life, shared throughout time', 1, NULL),
    ('Harlem and Poetry', 'Students will learn about the Harlem Renaissance, and will read Poetry and Narrative from that time to understand why people make art. They will then write their own poetry, expressing themselves','To understand why humans make art, as well as how to make art oneself', 2, NULL),
    ('American Fiction', 'Students will learn about the pivotal 1920/30 era in American History, and will use that knowledge to understand the fiction produced from that time, ultimately understanding that humans make art in context', 'To understand the historical context of the American 1920-30s fiction, and to understand the human condition as it creates art', 2, NULL),
    ('War Speeches', 'Students will read speeches from 3 different eras in time, with 3 different relationships to war', 'To understand how situations inform rhetoric', 1, 1),
    ('Dust Bowl', 'Students will learn the history of the Dust Bowl, and will look at histroical documents as well as artworks from that time period', 'To understand how Americans in the 1920-30s lived, as well as how they expressed that living', 2, 3),
    ('Harlem Renaissance', 'Students will read narrative and poetry from the Harlem Renaissance, as well as learn historical contexts, to understand this important era in American History','To understand the historical context of the Harlem Renaissance and connect that to the art made during the time', 2, 2),
    ('Poetry', 'Students will read a variety of poetry from a variety of forms, writing their own poetry until publishing a full chapbook of poems', 'To understand how and why humans write poetry, as well as to write poetry oneself', 2, 2);

INSERT INTO lessonUnit (lessonFK, unitFK) VALUES
    (1, 4),
    (2, 4),
    (3, 4),
    (4, 5),
    (5, 6),
    (6, 7);

INSERT INTO objective (name) VALUES
    ('Understand how to close read poetry using annotation'),
    ('Develop an understanding of the cultural and intellectual movement that categorized the Harlem Renaissance'),
    ('Work with a partner to tackle difficult questions, demonstrating self-motivation and resilience.'),
    ('Understand the historical context of Of Mice and Men by participating in a “Dust Bowl Gallery Walk” and recording observations/questions in a graphic organizer.'),
    ('Develop an understanding of how people dealt with the economic and agricultural hardships of the 1930s by responding to images in speaking and writing.'),
    ('Orally discuss their questions and observations as class with their peers'),
    ('Understand the rhetorical situation, including context and exigence'),
    ('Develop an understanding of argument crafted through a series of rhetorical choices'),
    ('Identify claims and how the author organizes them with evidence in his introduction'),
    ('Identify syntactical choices the author makes and their rhetorical effect'),
    ('Present information in a clear and intelligible format that is appropriate for the audience'),
    ('Work collaboratively to produce a presentation that reflects effort and commitment'),
    ('Answer questions about student work competently and professionally'),
    ('Craft a line of reasoning that incorporates rhetorical choices that MacArthur makes'),
    ('Write poetry'),
    ('Enjoy poetry');

INSERT INTO lessonObjective (lessonFK, objectiveFK) VALUES
    (1, 7),
    (1, 8),
    (1, 9),
    (1, 10),
    (1, 11),
    (1, 12),
    (1, 13),
    (2, 7),
    (2, 9),
    (2, 14),
    (3, 7),
    (3, 8),
    (3, 9),
    (3, 10),
    (3, 11),
    (3, 13),
    (3, 14),
    (4, 5),
    (4, 4),
    (4,7),
    (5, 1),
    (5, 2),
    (5, 3),
    (5, 7),
    (6, 1),
    (6, 15),
    (6, 16);

INSERT INTO theme (name) VALUES
    ('War'),
    ('Rhetorical Choices'),
    ('Syntax'),
    ('Evidence'),
    ('Claims'),
    ('Argument'),
    ('Duty'),
    ('Honor'),
    ('Country'),
    ('Patriotism'),
    ('Valor'),
    ('Respect'),
    ('Argument'),
    ('Rhetoric'),
    ('Line of Reasoning'),
    ('Evidence'),
    ('Commentary'),
    ('Syntax'),
    ('Democracy'),
    ('Economics'),
    ('Agriculture'),
    ('Migration'),
    ('American Dream'),
    ('Poverty'),
    ('Scarcity'),
    ('Decisions'),
    ('Social responsibility'),
    ('Poetry'),
    ('Art'),
    ('Dreams'),
    ('Repression'),
    ('Culture'),
    ('Identity'),
    ('Imagery'),
    ('Metaphor'),
    ('Figurative language');

INSERT INTO lessonTheme (lessonFK, themeFK) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 6),
    (1, 7),
    (1, 8),
    (1, 12),
    (1, 14),
    (1, 16),
    (2, 1),
    (2, 2),
    (2, 5),
    (2, 7),
    (2, 8),
    (2, 15),
    (2, 17),
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 4),
    (3, 5),
    (3, 6),
    (3, 7),
    (3, 8),
    (3, 9),
    (3, 10),
    (3, 11),
    (3, 12),
    (3, 13),
    (3, 15),
    (3, 14),
    (3, 16),
    (3, 17),
    (3, 18),
    (3, 19),
    (3, 20),
    (4, 21),
    (4, 22),
    (4, 23),
    (4, 24),
    (4, 25),
    (4, 26),
    (4, 27),
    (5, 23),
    (5, 24),
    (5, 25),
    (5, 26),
    (5, 28),
    (5, 29),
    (5, 30),
    (5, 31),
    (5, 32),
    (5, 33),
    (5, 34),
    (5, 35),
    (5, 36),
    (6, 28),
    (6, 29),
    (6, 34),
    (6, 36);

INSERT INTO differentiation (strategy) VALUES
    ('Sentence Frames'),
    ('Restatement'),
    ('Modeling'),
    ('Multimodal Engagement'),
    ('Redirection and Refocus'),
    ('Read Aloud'),
    ('Think Aloud'),
    ('Audiobook'),
    ('Annotation Guide'),
    ('Tiered Vocabulary'),
    ('Scaffolded Instruction'),
    ('Peer Teaching'),
    ('Differentiated Reading Materials'),
    ('Graphic Organizer'),
    ('No Strategy');

INSERT INTO lessonDifferentiation(lessonFK, differentiationFK) VALUES
    (1, 8),
    (1, 3),
    (1, 4),
    (1, 12),
    (2, 1),
    (2, 3),
    (2, 14),
    (1, 9),
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 12),
    (3, 14),
    (5, 1),
    (5, 2),
    (5, 3),
    (5, 5),
    (5, 6),
    (5, 7),
    (5, 10),
    (5, 11),
    (4, 1),
    (4, 2),
    (4, 4),
    (4, 12),
    (4, 14),
    (6, 2),
    (6, 11),
    (6, 12),
    (1, 14),
    (1, 15),
    (2, 15),
    (3, 15),
    (4, 15),
    (5, 15),
    (6, 15);

INSERT INTO material (name, parentFK) VALUES
    ('Analog', NULL),
    ('Digital', NULL),
    ('Hand-out', 1),
    ('Instructions', 3),
    ('Passage/Excerpt', 3),
    ('Passage/Excerpt', 2),
    ('Graphic Organizer', 3),
    ('Laptop', 2),
    ('Poster Board', 1),
    ('Book', 1),
    ('Book', 2),
    ('Note cards', 1),
    ('Slideshow', 2),
    ('Photographs', 1),
    ('Photographs', 2),
    ('Visual Art', 1),
    ('Visual Art', 2),
    ('Pencil/Pen', 1),
    ('Markers', 1),
    ('Highlighters', 1),
    ('Lined Paper', 1),
    ('Word Document', 2),
    ('Video', 2),
    ('Video', 1),
    ('Notebook', 1),
    ('Notebook', 2);

INSERT INTO lessonMaterial (lessonFK, materialFK) VALUES
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 6),
    (1, 7),
    (1, 8),
    (1, 9),
    (1, 12),
    (1, 18),
    (1, 19),
    (1, 20),
    (2, 3),
    (2, 4),
    (2, 5),
    (2, 6),
    (2, 7),
    (2, 12),
    (2, 18),
    (2, 19),
    (2, 20),
    (3, 3),
    (3, 4),
    (3, 5),
    (3, 6),
    (3, 8),
    (3, 12),
    (3, 18),
    (3, 19),
    (3, 20),
    (3, 21),
    (3, 22),
    (4, 3),
    (4, 7),
    (4, 14),
    (4, 15),
    (4, 17),
    (4, 18),
    (4, 23),
    (4, 25),
    (4, 26),
    (5, 3),
    (5, 4),
    (5, 18),
    (5, 20),
    (5, 21),
    (6, 18),
    (6, 13),
    (6, 22);

INSERT INTO assessment (name, parentFK) VALUES
    ('Ungraded', NULL),
    ('Informal', NULL),
    ('Formative', NULL),
    ('Summative', NULL),
    ('Presentation', 4),
    ('Group Presentation', 5),
    ('Worksheet', 2),
    ('Worksheet', 3),
    ('Annotated Passage', 1),
    ('Annotated Passage', 2),
    ('Annotated Passage', 3),
    ('Activator', 1),
    ('Activator', 2),
    ('Exit Ticket', 1),
    ('Exit Ticket', 2),
    ('Handout (student-made)', 3),
    ('Handout (student made)', 4),
    ('Written Paragraph', 2),
    ('Written Paragraph', 3),
    ('Essay', 4),
    ('Dialectic Journal', 2),
    ('Dialectic Journal', 3),
    ('Poem', 1),
    ('Poem Chapbook', 4),
    ('Non-Assessment', NULL);

INSERT INTO lessonAssessment(lessonFK, assessmentFK) VALUES
    (1, 6),
    (1, 8),
    (1, 10),
    (1, 12),
    (1, 18),
    (2, 8),
    (2, 10),
    (2, 7),
    (3, 6),
    (3, 9),
    (3, 7),
    (3, 16),
    (3, 20),
    (4, 13),
    (4, 14),
    (4, 8),
    (4, 19),
    (5, 13),
    (5, 14),
    (5, 8),
    (5, 11),
    (5, 19),
    (6, 12),
    (6, 14),
    (6, 23),
    (1, 25),
    (2, 25),
    (3, 25),
    (4, 25),
    (5, 25),
    (6, 25);

INSERT INTO lessonAssessmentSkill(lessonAssessmentFK, lessonSkillFK) VALUES
    (1, 1),
    (1, 3),
    (2, 3),
    (2, 1),
    (1, 2),
    (3, 6),
    (5, 6),
    (6, 7),
    (6, 4),
    (6, 5),
    (7, 7),
    (9, 8),
    (9, 9),
    (9, 10),
    (9, 11),
    (11, 11),
    (11, 23),
    (12, 8),
    (12, 9),
    (12, 10),
    (12, 11),
    (13, 8),
    (13, 9),
    (13, 10),
    (13, 11),
    (13, 21),
    (13, 22),
    (13, 23),
    (16, 12),
    (16, 13),
    (16, 14),
    (17, 12),
    (17, 13),
    (17, 14),
    (20, 15),
    (20, 16),
    (20, 18),
    (21, 15),
    (21, 16),
    (21, 18),
    (22, 17),
    (25, 19),
    (25, 20);

INSERT INTO text (title) VALUES
    ('Pericles Funeral Oration'),
    ('Henry V'),
    ('Duty, Honor, Country'),
    ('Dust Bowl Photographs'),
    ('Of Mice and Men'),
    ('Harlem'),
    ('A Poem For S'),
    ('New ABCs');


INSERT INTO name (name) VALUES
    ('Pericles'),
    ('Herodotus'),
    ('William'),
    ('Shakespeare'),
    ('Douglas'),
    ('MacArthur'),
    ('Dorothea'),
    ('Lange'),
    ('John'),
    ('Steinbeck'),
    ('Langston'),
    ('Hughes'),
    ('Jessica'),
    ('Greenbaum'),
    ('Luis'),
    ('Fialho'),
    ('Seneca');

INSERT INTO author (fullname) VALUES
    ('Pericles'),
    ('Herodotus'),
    ('William Shakespeare'),
    ('Douglas MacArthur'),
    ('Dorothea Lange'),
    ('John Steinbeck'),
    ('Langston Hughes'),
    ('Jessica Greenbaum'),
    ('Luis Fialho'),
    ('Seneca the Elder');

INSERT INTO authorName (authorFK, nameFK, position) VALUES
    (1, 1, 1),
    (2, 2, 1),
    (3, 3, 1),
    (3, 4, 2),
    (4, 5, 1),
    (4, 6, 2),
    (5, 7, 1),
    (5, 8, 2),
    (6, 9, 1),
    (6, 10, 2),
    (7, 11, 1),
    (7, 12, 2),
    (8, 13, 1),
    (8, 14, 2),
    (9, 15, 1),
    (9, 16, 2),
    (10, 17, 1);

INSERT INTO textAuthor (textFK, authorFK) VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (5, 6),
    (6, 7),
    (7, 8),
    (8, 9);

INSERT INTO lessonText (lessonFK, textFK) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (4, 5),
    (5, 6),
    (6, 7),
    (6, 8);

-- CONRETE

INSERT INTO timeType (name, minuteValue) VALUES
    ('Block', 50),
    ('Long Block', 80),
    ('Short Block', 20),
    ('Minute', 1),
    ('Hour', 60),
    ('Period', 50);

INSERT INTO lessonUnitConcrete (lessonUnitFK, duration, timeTypeFK) VALUES
-- each row is a block of time comprising one unit
    (1, 6, 1),
    (2, 3, 1),
    (3, 5, 1),
    (4, 1, 1),
    (5, 2, 1),
    (6, 1, 1);

INSERT INTO lessonConcrete (lessonDate, lessonUnitConcreteFK, lessonDay, lessonPATH) VALUES
-- each row is a single school day lesson
    ('2023-01-11', 1, 1, '~/Documents/LP/AP11/Q3/Pericles__1.pdf'),
    ('2023-01-12', 1, 2, '~/Documents/LP/AP11/Q3/Pericles_2-3.pdf'),
    ('2023-01-13', 1, 3, '~/Documents/LP/AP11/Q3/Pericles_2-3.pdf'),
    ('2023-01-14', 1, 4, '~/Documents/LP/AP11/Q3/Pericles_4.pdf'),
    ('2023-01-15', 1, 5, '~/Documents/LP/AP11/Q3/Pericles_5.pdf'),
    ('2023-01-18', 1, 6, '~/Documents/LP/AP11/Q3/Pericles_6.pdf'),
    ('2023-01-20', 2, 1, '~/Documents/LP/AP11/Q3/HenryV_1.pdf'),
    ('2023-01-21', 2, 2, '~/Documents/LP/AP11/Q3/HenryV_2-3.pdf'),
    ('2023-01-22', 2, 3, '~/Documents/LP/AP11/Q3/HenryV_2-3.pdf'),
    ('2023-01-25', 3, 1, '~/Documents/LP/AP11/Q3/MacArthur_1.pdf'),
    ('2023-01-26', 3, 2, '~/Documents/LP/AP11/Q3/MacArthur_2-3.pdf'),
    ('2023-01-27', 3, 3, '~/Documents/LP/AP11/Q3/MacArthur_2-3.pdf'),
    ('2023-01-28', 3, 4, '~/Documents/LP/AP11/Q3/MacArthur_4.pdf'),
    ('2023-01-29', 3, 5, '~/Documents/LP/AP11/Q3/MacArthur_5.pdf'),
    ('2022-11-15', 4, 1, '~/Documents/LP/ELA9/Q2/DBPhotos_1.pdf'),
    ('2023-01-14', 5, 1, '~/Documents/LP/ELA9/Q3/Harlem_1-2.pdf'),
    ('2023-01-15', 5, 2, '~/Documents/LP/ELA9/Q3/Harlem_1-2.pdf'),
    ('2023-01-21', 6, 1, '~/Documents/LP/BLANK.pdf');

INSERT INTO materialConcrete (lessonMaterialFK, lessonConcreteFK, lessonAssessmentFK, lessonDifferentiationFK, materialPATH) VALUES
-- each row is a single tangible material used
    (1, 2, 8, 12, '~/Documents/AP11/Q3/Pericles_Handout.pdf'),
    (2, 2, 1, 2, '~/Documents/AP11/Q3/Pericles_Instructions.pdf'),
    (4, 1, 3, 8, '~/Documents/AP11/Q3/Pericles_Passage.pdf'),
    (5, 2, 26, 30, '~/Documents/AP11/Q3/Pericles_GrOrg.pdf'),
    (12, 7, 8, 5, '~/Documents/AP11/Q3/HenryV_Handout.pdf'),
    (13, 7, 27, 6, '~/Documents/AP11/Q3/HenryV_Instructions.pdf'),
    (15, 7, 7, 8, '~/Documents/AP11/Q3/HenryV_Passage.pdf'),
    (16, 8, 6, 7, '~/Documents/AP11/Q3/HenryV_GrOrg.pdf'),
    (21, 10, 11, 9, '~/Documents/AP11/Q3/MacArthur_Handout_1.pdf'),
    (22, 10, 9, 11, '~/Documents/AP11/Q3/MacArthur_Instructions.pdf'),
    (24, 10, 10, 33, '~/Documents/AP11/Q3/MacArthur_Passage.pdf'),
    (31, 13, 13, 12, '~/Documents/AP11/Q3/MacArthur_BlankDoc.docx'),
    (21, 13, 12, 10, '~/Documents/AP11/Q3/MacArthur_Handout_2.pdf'),
    (32, 15, 16, 22, '~/Documents/ELA9/Q2/DBPhotos_Handout.pdf'),
    (33, 15, 16, 26, '~/Documents/ELA9/Q2/DBPhotos_GrOrg.pdf'),
    (34, 15, 28, 24, '~/Documents/ELA9/Q2/DBPhotos.pdf'),
    (36, 15, 28, 34, '~/Documents/BLANK.pdf'),
    (38, 15, 28, 34, '~/Documents/BLANK.pdf'),
    (41, 16, 20, 14, '~/Documents/ELA9/Q3/Harlem_Handout.pdf'),
    (42, 16, 21, 16, '~/Documents/ELA9/Q3/Harlem_Instructions.pdf'),
    (42, 16, 22, 7, '~/Documents/ELA9/Q2/Harlem_Insturctions_Paragraph.pdf'),
    (47, 18, 30, 28, '~/Documents/ELA9/Q3/Poetry_Slideshow.ppt'),
    (48, 18, 30, 36, '~/Documents/ELA9/Q3/Abcedarian.docx');

-- -- -- QUERIES -----------------

-- Show lesson, date, and file location
SELECT
    l.title AS "Lesson",
    lc.lessonDate AS "Date",
    lc.lessonPATH AS "Location"
FROM lessonConcrete as lc
    JOIN lessonUnitConcrete AS luc ON lc.lessonUnitConcreteFK = luc.lessonUnitConcretePK
    JOIN lessonUnit AS lu ON luc.lessonUnitFK = lu.lessonUnitPK
    JOIN lesson AS l ON lu.lessonFK = l.lessonPK;

-- Shows which skills are tested in each lesson assessment
SELECT
    l.title AS "Lesson",
    a.name AS "Assessment",
    s.name AS "Skill"
FROM lessonAssessmentSkill AS las
    JOIN lessonAssessment la ON las.lessonAssessmentFK = la.lessonAssessmentPK
    JOIN lessonSkill ls ON las.lessonSkillFK = ls.lessonSkillPK
    JOIN lesson l ON ls.lessonFK = lessonPK
    JOIN assessment a ON la.assessmentFK = a.assessmentPK
    JOIN skill s ON ls.skilLFK = s.skillPK
ORDER BY l.title, a.name;

-- Show each lesson's unit and the durarion
SELECT
    l.title AS "Lesson",
    CONCAT(u.name, " (from) ", x.name) AS "Unit",
    CONCAT(luc.duration, " ", tt.name) AS "Duration"
FROM lessonUnitConcrete AS luc
    JOIN lessonUnit AS lu ON luc.lessonUnitFK = lessonUnitPK
    JOIN timeType AS tt ON luc.timeTypeFK = timeTypePK
    JOIN lesson AS l ON lu.lessonFK = l.lessonPK
    JOIN unit AS u ON lu.unitFK = u.unitPK
    JOIN unit x ON u.parentFK = x.unitPK;

-- Shows which concrete materials are used in each unit by subject
SELECT
    CONCAT ("[",s.grade,"] ",s.name) AS "Subject",
    u.name AS "Unit",
    m.name AS "Material",
    x.name AS "Material Type"
FROM lessonMaterial as lm
    JOIN lesson as l ON lm.lessonFK = l.lessonPK
    JOIN material as m on lm.materialFK = m.materialPK
    JOIN materialConcrete as mc ON lm.lessonMaterialPK = mc.lessonMaterialFK
    JOIN lessonUnit AS lu ON lu.lessonFK = l.lessonPK
    JOIN unit AS u ON lu.unitFK = u.unitPK
    JOIN lessonSubject AS ls ON ls.lessonFK = l.lessonPK
    JOIN subject AS s ON ls.subjectFK = s.subjectPK
    JOIN material x ON m.parentFK = x.materialPK;

-- Show the materials needed for the first lesson of every unit
SELECT
    lc.lessonDate AS "Date",
    l.title AS "Lesson",
    m.name AS "Material",
    mc.materialPATH AS "Location"
FROM lessonUnitConcrete AS luc
    JOIN lessonUnit AS lu ON luc.lessonUnitFK = lessonUnitPK
    JOIN lesson AS l ON lu.lessonFK = l.lessonPK
    JOIN lessonMaterial AS lm ON lm.lessonFK = l.lessonPK
    JOIN material AS m ON lm.materialFK = m.materialPK
    JOIN materialConcrete AS mc ON lm.lessonMaterialPK = mc.lessonMaterialFK
    JOIN lessonConcrete AS lc ON mc.lessonConcreteFK = lc.lessonConcretePK
    WHERE lc.lessonDay = 1;

-- Show all Assessments and their Materials for the First Week of January
SELECT
    lc.lessonDate AS "Date",
    l.title AS "Lesson",
    a.name AS "Assessment",
    m.name AS "Material",
    mc.materialPATH AS "Location"
FROM materialConcrete as mc
    JOIN lessonMaterial AS lm ON mc.lessonMaterialFK = lm.lessonMaterialPK
    JOIN lessonAssessment AS la ON mc.lessonAssessmentFK = la.lessonAssessmentPK
    JOIN lessonConcrete AS lc ON mc.lessonConcreteFK = lc.lessonConcretePK
    JOIN lesson AS l ON lm.lessonFK = l.lessonPK
    JOIN material AS m ON lm.materialFK = m.materialPK
    JOIN assessment AS a ON la.assessmentFK = a.assessmentPK
    WHERE lc.lessonDate BETWEEN '2023-01-11' AND '2023-01-15';

-- Shows ALL materials used by the English Class in 9th grade
SELECT
    CONCAT ("[",s.grade,"] ",s.name) AS "Subject",
    u.name AS "Unit",
    m.name AS "Material",
    x.name AS "Material Type"
FROM lessonMaterial as lm
    JOIN lesson as l ON lm.lessonFK = l.lessonPK
    JOIN material as m on lm.materialFK = m.materialPK
    JOIN lessonUnit AS lu ON lu.lessonFK = l.lessonPK
    JOIN unit AS u ON lu.unitFK = u.unitPK
    JOIN lessonSubject AS ls ON ls.lessonFK = l.lessonPK
    JOIN subject AS s ON ls.subjectFK = s.subjectPK
    JOIN material x ON m.parentFK = x.materialPK
    WHERE s.name = "English" AND s.grade = 9;

-- Shows which materials are used in each concrete lesson, as well as the material type and assessment and/or differentiation
SELECT
    l.title AS "Lesson",
    m.name AS "Material",
    a.name AS "Assessment",
    d.strategy AS "Differentiation"
FROM materialConcrete as mc
    JOIN lessonMaterial AS lm ON mc.lessonMaterialFK = lm.lessonMaterialPK
    JOIN lessonAssessment AS la ON mc.lessonAssessmentFK = la.lessonAssessmentPK
    JOIN lessonDifferentiation AS ld ON mc.lessonDifferentiationFK = ld.lessonDifferentiationPK
    JOIN lesson AS l ON lm.lessonFK = l.lessonPK
    JOIN material AS m ON lm.materialFK = m.materialPK
    JOIN assessment AS a ON la.assessmentFK = a.assessmentPK
    JOIN differentiation AS d ON ld.differentiationFK = d.differentiationPK;

-- Show themes for each lesson
SELECT
    l.title AS "Lesson",
    t.name AS "Themes"
FROM lessonTheme AS lt
    JOIN theme AS t ON lt.themeFK = t.themePK
    JOIN lesson AS l ON l.lessonPK = lt.lessonFK;

-- Show objectives for each lesson
SELECT
    l.title AS "Lesson",
    o.name AS "Objectives"
FROM lessonObjective AS lo
    JOIN objective AS o ON lo.objectiveFK = o.objectivePK
    JOIN lesson AS l ON l.lessonPK = lo.lessonFK;

-- Show the most popular skills used across lessons
SELECT
    s.name AS "Skill",
    COUNT(*) AS "Count"
FROM lessonSkill AS ls
    JOIN lesson AS l ON ls.lessonFK = l.lessonPK
    JOIN skill AS s ON ls.skillFK = s.skillPK
GROUP BY ls.skillFK
ORDER BY COUNT(*) DESC;

-- Show the most popular assessments used across lessons
SELECT
    a.name AS "Assessment",
    COUNT(*) AS "Count"
FROM lessonAssessment AS la
    JOIN lesson AS l ON la.lessonFK = l.lessonPK
    JOIN assessment AS a ON la.assessmentFK = a.assessmentPK
WHERE a.name != "Non-Assessment"
GROUP BY la.assessmentFK
ORDER BY COUNT(*) DESC;

-- Show author name for each text taught in each lesson
SELECT
    t.title AS "Title",
    fn.name AS "First Name",
    n.name AS "Last Name", l.title AS "Lesson"
FROM author AS a
    JOIN authorName AS an_f
    ON a.authorPK = an_f.authorFK AND an_f.position = 1
    JOIN name AS fn ON an_f.nameFK = fn.namePK
    LEFT JOIN authorName AS an_l ON a.authorPK = an_l.authorFK AND an_l.position = 2
    LEFT JOIN name AS n ON an_l.nameFK = n.namePK
    JOIN textAuthor AS ta ON ta.authorFK = a.authorPK
    JOIN text AS t ON ta.textFK = t.textPK
    JOIN lessonText AS lt ON t.textPK = lt.textFK
    JOIN lesson AS l ON l.lessonPK = lt.lessonFK;
