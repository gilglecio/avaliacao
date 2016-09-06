-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: 06/09/2016 às 17:15
-- Versão do servidor: 5.5.49-0ubuntu0.14.04.1
-- Versão do PHP: 5.5.9-1ubuntu4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Banco de dados: `avaliacao`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `alternatives`
--

CREATE TABLE IF NOT EXISTS `alternatives` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=54 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `answers`
--

CREATE TABLE IF NOT EXISTS `answers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `evaluation_sending_id` int(10) unsigned NOT NULL,
  `issue_id` int(10) unsigned NOT NULL,
  `valued_id` int(10) unsigned NOT NULL,
  `answer` text COLLATE utf8_unicode_ci,
  `justification` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_answers_issues1` (`issue_id`),
  KEY `fk_answers_users1` (`valued_id`),
  KEY `fk_answers_evaluation_sendings1` (`evaluation_sending_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1987 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `averages`
--

CREATE TABLE IF NOT EXISTS `averages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `average` float NOT NULL,
  `evaluator_id` int(10) unsigned NOT NULL,
  `valued_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `updated_at` datetime DEFAULT NULL,
  `evaluation_sending_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_averages_users1` (`valued_id`),
  KEY `fk_averages_users2` (`evaluator_id`),
  KEY `fk_averages_evaluation_sendings1` (`evaluation_sending_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `charges`
--

CREATE TABLE IF NOT EXISTS `charges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=23 ;

--
-- Fazendo dump de dados para tabela `charges`
--

INSERT INTO `charges` (`id`, `name`) VALUES
(20, 'programador'),
(21, 'testador'),
(22, 'gerente');

-- --------------------------------------------------------

--
-- Estrutura para tabela `corrections`
--

CREATE TABLE IF NOT EXISTS `corrections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `answer_id` int(10) unsigned NOT NULL,
  `evaluator_id` int(10) unsigned NOT NULL,
  `note` float NOT NULL,
  `justification` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_corrections_answers1` (`answer_id`),
  KEY `fk_corrections_users1` (`evaluator_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1348 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `evaluations`
--

CREATE TABLE IF NOT EXISTS `evaluations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_at` datetime NOT NULL,
  `end_at` datetime NOT NULL,
  `message_email` text COLLATE utf8_unicode_ci,
  `mail_bcc` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `is_alerted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_evaluations_users1` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=135 ;

--
-- Fazendo dump de dados para tabela `evaluations`
--

INSERT INTO `evaluations` (`id`, `user_id`, `name`, `subject`, `start_at`, `end_at`, `message_email`, `mail_bcc`, `created_at`, `updated_at`, `status`, `is_alerted`) VALUES
(134, 135, 'erwerwer', '', '2016-06-10 00:00:00', '2016-06-12 00:00:00', 'werwerwer', '[]', '2016-09-06 17:08:53', '2016-09-06 17:08:53', 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `evaluation_evaluators`
--

CREATE TABLE IF NOT EXISTS `evaluation_evaluators` (
  `evaluation_id` int(10) unsigned NOT NULL,
  `evaluator_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`evaluation_id`,`evaluator_id`),
  KEY `fk_evaluations_has_users_users1` (`evaluator_id`),
  KEY `fk_evaluations_has_users_evaluations1` (`evaluation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `evaluation_groups`
--

CREATE TABLE IF NOT EXISTS `evaluation_groups` (
  `evaluation_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`evaluation_id`,`group_id`),
  KEY `fk_evaluations_has_groups_groups1` (`group_id`),
  KEY `fk_evaluations_has_groups_evaluations1` (`evaluation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Fazendo dump de dados para tabela `evaluation_groups`
--

INSERT INTO `evaluation_groups` (`evaluation_id`, `group_id`) VALUES
(134, 60);

-- --------------------------------------------------------

--
-- Estrutura para tabela `evaluation_questionnaires`
--

CREATE TABLE IF NOT EXISTS `evaluation_questionnaires` (
  `evaluation_id` int(10) unsigned NOT NULL,
  `questionnaire_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`evaluation_id`,`questionnaire_id`),
  KEY `fk_evaluations_has_questionnaires_questionnaires1` (`questionnaire_id`),
  KEY `fk_evaluations_has_questionnaires_evaluations1` (`evaluation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Fazendo dump de dados para tabela `evaluation_questionnaires`
--

INSERT INTO `evaluation_questionnaires` (`evaluation_id`, `questionnaire_id`) VALUES
(134, 46);

-- --------------------------------------------------------

--
-- Estrutura para tabela `evaluation_sendings`
--

CREATE TABLE IF NOT EXISTS `evaluation_sendings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `evaluation_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sendings_evaluations1` (`evaluation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=222 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `status` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=61 ;

--
-- Fazendo dump de dados para tabela `groups`
--

INSERT INTO `groups` (`id`, `name`, `created_at`, `updated_at`, `is_delete`, `status`) VALUES
(60, 'programadores', '2016-09-06 17:00:43', '2016-09-06 17:00:43', 0, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `group_members`
--

CREATE TABLE IF NOT EXISTS `group_members` (
  `group_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `status` smallint(6) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`group_id`,`user_id`),
  KEY `fk_groups_has_users_users1` (`user_id`),
  KEY `fk_groups_has_users_groups` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Fazendo dump de dados para tabela `group_members`
--

INSERT INTO `group_members` (`group_id`, `user_id`, `status`, `created_at`) VALUES
(60, 136, 0, '2016-09-06 17:00:45');

-- --------------------------------------------------------

--
-- Estrutura para tabela `issues`
--

CREATE TABLE IF NOT EXISTS `issues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `enunciation` text COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(25) COLLATE utf8_unicode_ci NOT NULL COMMENT 'open;\nscale;\nalternative;\nalternatives;\nboolean;\n0-10;',
  `status` smallint(6) NOT NULL DEFAULT '1',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '1',
  `accepted_justification` tinyint(1) NOT NULL DEFAULT '0',
  `justification_required` tinyint(1) NOT NULL DEFAULT '0',
  `page` smallint(6) NOT NULL DEFAULT '1',
  `min_choice` smallint(6) DEFAULT '1',
  `max_choice` smallint(6) DEFAULT NULL,
  `max_note` smallint(6) NOT NULL DEFAULT '10',
  `min_note` smallint(6) NOT NULL DEFAULT '0',
  `scale_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_issues_users1` (`user_id`),
  KEY `fk_issues_scales1` (`scale_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=111 ;

--
-- Fazendo dump de dados para tabela `issues`
--

INSERT INTO `issues` (`id`, `user_id`, `enunciation`, `type`, `status`, `is_delete`, `created_at`, `updated_at`, `required`, `accepted_justification`, `justification_required`, `page`, `min_choice`, `max_choice`, `max_note`, `min_note`, `scale_id`) VALUES
(109, 135, 'CSS Ã© uma linguagem de programaÃ§Ã£o?', 'boolean', 1, 0, '2016-09-06 17:03:01', '2016-09-06 17:03:01', 1, 0, 0, 1, 1, NULL, 10, 1, NULL),
(110, 135, 'CÃ³pia de: CSS Ã© uma linguagem de programaÃ§Ã£o?', 'boolean', 1, 0, '2016-09-06 17:07:22', '2016-09-06 17:07:22', 1, 0, 0, 1, 1, NULL, 10, 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `issue_alternatives`
--

CREATE TABLE IF NOT EXISTS `issue_alternatives` (
  `issue_id` int(10) unsigned NOT NULL,
  `alternative_id` int(10) unsigned NOT NULL,
  `position` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`issue_id`,`alternative_id`),
  KEY `fk_issues_has_alternatives_alternatives1` (`alternative_id`),
  KEY `fk_issues_has_alternatives_issues1` (`issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `models`
--

CREATE TABLE IF NOT EXISTS `models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pdfs`
--

CREATE TABLE IF NOT EXISTS `pdfs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sending_id` int(11) NOT NULL,
  `evaluator_id` int(11) NOT NULL,
  `salary` float(10,2) NOT NULL,
  `new_salary` float(10,2) DEFAULT NULL,
  `final_note` float(10,2) DEFAULT NULL,
  `perf` float(10,2) NOT NULL,
  `bonus` float(10,2) NOT NULL,
  `bonus_prop` float(10,2) NOT NULL,
  `nr_salary_prop` float(10,2) NOT NULL,
  `perf_prop` float(10,2) NOT NULL,
  `nr_salary` float(10,2) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `evaluator_note` float(10,2) NOT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sending_id` (`sending_id`),
  KEY `evaluator_id` (`evaluator_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=101 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `questionnaires`
--

CREATE TABLE IF NOT EXISTS `questionnaires` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name_private` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_questionnaires_users1` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=47 ;

--
-- Fazendo dump de dados para tabela `questionnaires`
--

INSERT INTO `questionnaires` (`id`, `name`, `name_private`, `created_at`, `updated_at`, `is_delete`, `user_id`) VALUES
(46, 'LÃ³gica de ProgramaÃ§Ã£o', 'LÃ³gica de ProgramaÃ§Ã£o', '2016-09-06 10:44:09', '2016-09-06 17:02:23', 0, 135);

-- --------------------------------------------------------

--
-- Estrutura para tabela `questionnaire_issues`
--

CREATE TABLE IF NOT EXISTS `questionnaire_issues` (
  `questionnaire_id` int(10) unsigned NOT NULL,
  `issue_id` int(10) unsigned NOT NULL,
  `order` int(11) NOT NULL DEFAULT '10',
  `value` float NOT NULL DEFAULT '10',
  PRIMARY KEY (`questionnaire_id`,`issue_id`),
  KEY `fk_questionnaires_has_issues_issues1` (`issue_id`),
  KEY `fk_questionnaires_has_issues_questionnaires1` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Fazendo dump de dados para tabela `questionnaire_issues`
--

INSERT INTO `questionnaire_issues` (`questionnaire_id`, `issue_id`, `order`, `value`) VALUES
(46, 109, 10, 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `ratings`
--

CREATE TABLE IF NOT EXISTS `ratings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=24 ;

--
-- Fazendo dump de dados para tabela `ratings`
--

INSERT INTO `ratings` (`id`, `name`) VALUES
(21, 'junior'),
(22, 'pleno'),
(23, 'sÃªnior');

-- --------------------------------------------------------

--
-- Estrutura para tabela `scales`
--

CREATE TABLE IF NOT EXISTS `scales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `scale_options`
--

CREATE TABLE IF NOT EXISTS `scale_options` (
  `scale_id` int(10) unsigned NOT NULL,
  `scale_row_id` int(10) unsigned NOT NULL,
  `position` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`scale_id`,`scale_row_id`),
  KEY `fk_scale_names_has_scale_rows_scale_rows1` (`scale_row_id`),
  KEY `fk_scale_names_has_scale_rows_scale_names1` (`scale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `scale_rows`
--

CREATE TABLE IF NOT EXISTS `scale_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `position` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sendings`
--

CREATE TABLE IF NOT EXISTS `sendings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `valued_id` int(10) unsigned NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `evaluation_sending_id` int(10) unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `answered_at` datetime DEFAULT NULL,
  `corrected_at` datetime DEFAULT NULL,
  `viewed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sendings_users1` (`valued_id`),
  KEY `fk_sendings_evaluation_sendings1` (`evaluation_sending_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=444 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sending_bcc`
--

CREATE TABLE IF NOT EXISTS `sending_bcc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluation_sending_id` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sending_evaluators`
--

CREATE TABLE IF NOT EXISTS `sending_evaluators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `evaluator_id` int(10) unsigned NOT NULL,
  `evaluation_sending_id` int(10) unsigned NOT NULL,
  `sending_id` int(10) unsigned NOT NULL,
  `token` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `evaluate` tinyint(1) NOT NULL DEFAULT '1',
  `is_corrected` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_sending_evaluators_users1` (`evaluator_id`),
  KEY `fk_sending_evaluators_evaluation_sendings1` (`evaluation_sending_id`),
  KEY `fk_sending_evaluators_sendings1` (`sending_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=173 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `site_description` text COLLATE utf8_unicode_ci NOT NULL,
  `src_logo` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL,
  `site_email` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` char(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT '0=n confirmado;\n1=confirmado;\n2=bloqueado;',
  `birth` date DEFAULT NULL,
  `graduated_at` smallint(4) DEFAULT NULL,
  `salary` float(10,2) DEFAULT NULL,
  `profile_type` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=avaliado;\n2=avaliador;',
  `entry_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=137 ;

--
-- Fazendo dump de dados para tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`, `created_at`, `updated_at`, `is_delete`, `status`, `birth`, `graduated_at`, `salary`, `profile_type`, `entry_at`) VALUES
(135, 'gilglecio', 'gilglecio_765@hotmail.com', 'gilglecio', '$1$oL91gTT5$c//sEfhQM1l7x8TBzeZxw1', '2016-09-06 10:39:54', '2016-09-06 10:39:54', 0, 1, '1994-03-16', 2016, 0.00, 'admin', '2016-09-06 00:00:00'),
(136, 'fernando dutra', 'fernando@inova2b.com.br', NULL, NULL, '2016-09-06 16:58:54', '2016-09-06 16:58:54', 0, 0, '1994-03-16', 2011, 5.00, 'valued', '2000-01-01 00:00:00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `user_charges`
--

CREATE TABLE IF NOT EXISTS `user_charges` (
  `user_id` int(10) unsigned NOT NULL,
  `charge_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`charge_id`),
  KEY `fk_users_has_charges_charges1` (`charge_id`),
  KEY `fk_users_has_charges_users1` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Fazendo dump de dados para tabela `user_charges`
--

INSERT INTO `user_charges` (`user_id`, `charge_id`) VALUES
(136, 20);

-- --------------------------------------------------------

--
-- Estrutura para tabela `user_ratings`
--

CREATE TABLE IF NOT EXISTS `user_ratings` (
  `user_id` int(10) unsigned NOT NULL,
  `rating_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`rating_id`),
  KEY `fk_users_has_ratings_ratings1` (`rating_id`),
  KEY `fk_users_has_ratings_users1` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Fazendo dump de dados para tabela `user_ratings`
--

INSERT INTO `user_ratings` (`user_id`, `rating_id`) VALUES
(136, 22);

--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `fk_answers_evaluation_sendings1` FOREIGN KEY (`evaluation_sending_id`) REFERENCES `evaluation_sendings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_answers_issues1` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_answers_users1` FOREIGN KEY (`valued_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `averages`
--
ALTER TABLE `averages`
  ADD CONSTRAINT `fk_averages_evaluation_sendings1` FOREIGN KEY (`evaluation_sending_id`) REFERENCES `evaluation_sendings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_averages_users1` FOREIGN KEY (`valued_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_averages_users2` FOREIGN KEY (`evaluator_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `corrections`
--
ALTER TABLE `corrections`
  ADD CONSTRAINT `fk_corrections_answers1` FOREIGN KEY (`answer_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_corrections_users1` FOREIGN KEY (`evaluator_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `evaluations`
--
ALTER TABLE `evaluations`
  ADD CONSTRAINT `fk_evaluations_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `evaluation_evaluators`
--
ALTER TABLE `evaluation_evaluators`
  ADD CONSTRAINT `fk_evaluations_has_users_evaluations1` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_evaluations_has_users_users1` FOREIGN KEY (`evaluator_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `evaluation_groups`
--
ALTER TABLE `evaluation_groups`
  ADD CONSTRAINT `fk_evaluations_has_groups_evaluations1` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_evaluations_has_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `evaluation_questionnaires`
--
ALTER TABLE `evaluation_questionnaires`
  ADD CONSTRAINT `fk_evaluations_has_questionnaires_evaluations1` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_evaluations_has_questionnaires_questionnaires1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `evaluation_sendings`
--
ALTER TABLE `evaluation_sendings`
  ADD CONSTRAINT `fk_sendings_evaluations1` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `fk_groups_has_users_groups` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_groups_has_users_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `issues`
--
ALTER TABLE `issues`
  ADD CONSTRAINT `fk_issues_scales1` FOREIGN KEY (`scale_id`) REFERENCES `scales` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_issues_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `issue_alternatives`
--
ALTER TABLE `issue_alternatives`
  ADD CONSTRAINT `fk_issues_has_alternatives_alternatives1` FOREIGN KEY (`alternative_id`) REFERENCES `alternatives` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_issues_has_alternatives_issues1` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `questionnaires`
--
ALTER TABLE `questionnaires`
  ADD CONSTRAINT `fk_questionnaires_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `questionnaire_issues`
--
ALTER TABLE `questionnaire_issues`
  ADD CONSTRAINT `fk_questionnaires_has_issues_issues1` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_questionnaires_has_issues_questionnaires1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `scale_options`
--
ALTER TABLE `scale_options`
  ADD CONSTRAINT `fk_scale_names_has_scale_rows_scale_names1` FOREIGN KEY (`scale_id`) REFERENCES `scales` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_scale_names_has_scale_rows_scale_rows1` FOREIGN KEY (`scale_row_id`) REFERENCES `scale_rows` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `sendings`
--
ALTER TABLE `sendings`
  ADD CONSTRAINT `fk_sendings_evaluation_sendings1` FOREIGN KEY (`evaluation_sending_id`) REFERENCES `evaluation_sendings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sendings_users1` FOREIGN KEY (`valued_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `sending_evaluators`
--
ALTER TABLE `sending_evaluators`
  ADD CONSTRAINT `fk_sending_evaluators_evaluation_sendings1` FOREIGN KEY (`evaluation_sending_id`) REFERENCES `evaluation_sendings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sending_evaluators_sendings1` FOREIGN KEY (`sending_id`) REFERENCES `sendings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sending_evaluators_users1` FOREIGN KEY (`evaluator_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `user_charges`
--
ALTER TABLE `user_charges`
  ADD CONSTRAINT `fk_users_has_charges_charges1` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_has_charges_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `user_ratings`
--
ALTER TABLE `user_ratings`
  ADD CONSTRAINT `fk_users_has_ratings_ratings1` FOREIGN KEY (`rating_id`) REFERENCES `ratings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_has_ratings_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;