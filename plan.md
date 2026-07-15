1. **Create Missing Enums:**
   - Enum 51004 Honda CRM Activity Status (Open, Completed, Cancelled)
   - Enum 51005 Honda Opportunity CRM Stage (New, Initial Contact, Needs Analysis, Vehicle Selection, Test Drive, Quotation Ready)
   - Enum 51006 Honda Opportunity Result (Open, Ready for Quotation, Won, Lost, Cancelled)
   - Enum 51007 Honda Lost Reason
   - Enum 51008 Honda Contact Preference

2. **Create Automotive Master Tables:**
   - Table 51000 Honda Dealer
   - Table 51001 Honda Vehicle Model
   - Table 51002 Honda Vehicle Variant

3. **Create the Master Pages:**
   - Page 51000 Honda Dealer Card
   - Page 51001 Honda Dealer List
   - Page 51002 Honda Vehicle Model Card
   - Page 51003 Honda Vehicle Model List
   - Page 51004 Honda Vehicle Variant List

4. **Extend the Standard Contact Table & Pages (Steps 4 & 5):**
   - TableExtension 51000 Honda Contact Ext.
   - PageExtension 51000 Honda Contact Card Ext.
   - PageExtension 51001 Honda Contact List Ext.

5. **Create Duplicate-Contact Detection (Step 6):**
   - Codeunit for checking duplicates based on Email and Phone.

6. **Extend the Standard Opportunity Table (Step 7):**
   - TableExtension 51001 Honda Opportunity Ext.

7. **Create the Opportunity Vehicle Line & Pages (Steps 8 & 9):**
   - Table 51003 Honda Opp. Vehicle Line
   - Page 51005 Honda Opp. Vehicle Subform
   - Page 51006 Honda Opp. Vehicle Lines (List)

8. **Create CRM Activities (Step 10 & 11):**
   - Table 51004 Honda CRM Activity
   - Pages 51007-51010 (Card, List, Parts)

9. **Create Opportunity Status History (Step 13):**
   - Table 51005 Honda Opp. Status Entry
   - Page 51011 Honda Opp. Status Entries

10. **Extend the Opportunity Pages (Step 14):**
    - PageExtension 51002 Honda Opportunity Card Ext.
    - PageExtension 51003 Honda Opportunity List Ext.

11. **Create Codeunit 51000 Honda CRM Management & Codeunit 51001 Honda CRM Event Subscriber (Steps 12, 15-21):**
    - Opportunity creation from Contact
    - Sales Cycle and Activation
    - Controlled CRM Stage Movement
    - Mark Ready for Quotation
    - Mark Opportunity as Lost
    - Cancel Opportunity
    - Add Integration Events

12. **Create Permissions (Step 23):**
    - PermissionSet 51000 HONDA CRM USER
    - PermissionSet 51001 HONDA CRM MANAGER

13. **Write Tests / Seed Data (Step 25):**
    - Note: The prompt doesn't ask to execute manual tests, but rather just "write code according to requirement". I'll create an Install Codeunit or similar to setup standard data.

14. **Complete Pre Commit Steps:**
    - Call pre commit tools to ensure proper testing, validation, and reflections are done.

15. **Submit the Changes:**
    - Commit and push to git.
