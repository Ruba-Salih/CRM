-- ==========================================================
-- CRM Ticketing System Refinement - Version 2.0
-- Description: Switching to Platform Strings, deleting crm_platforms table, 
-- and adding support for Reactions and Calls.
-- ==========================================================

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Update crm_ticket_messages to support the simplified string-based platform approach
-- and new interaction types (reactions, calls).
ALTER TABLE `crm_ticket_messages` 
  DROP COLUMN IF EXISTS `platform_id`, 
  ADD COLUMN `platform` varchar(50) DEFAULT NULL AFTER `crm_ticket_id` 
    COMMENT 'Source platform name: whatsapp, facebook_post, facebook_message, instagram, pstn, sms, etc.',
  MODIFY COLUMN `interaction_type` enum('message', 'comment', 'reaction', 'call') DEFAULT 'message'
    COMMENT 'Type of interaction for scoring and display',
  CHANGE COLUMN `external_id` `external_id` varchar(255) DEFAULT NULL 
    COMMENT 'The primary key ID from the source table (e.g., whatsapp_messages.id or crm_logs.id)';

-- 2. Delete the crm_platforms table as it is now redundant
DROP TABLE IF EXISTS `crm_platforms`;

-- 3. (Optional) If you have existing data, you might want to map old IDs to strings here.
-- Example: 
-- UPDATE crm_ticket_messages SET platform = 'facebook' WHERE platform_id = 1;

SET FOREIGN_KEY_CHECKS = 1;
