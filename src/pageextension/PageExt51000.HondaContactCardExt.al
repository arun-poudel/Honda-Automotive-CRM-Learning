pageextension 51000 "Honda Contact Card Ext." extends "Contact Card"
{
    layout
    {
        addafter(General)
        {
            group(HondaCRM)
            {
                Caption = 'Honda CRM';
                field("Honda Customer Type"; Rec."Honda Customer Type") { ApplicationArea = All; }
                field("Honda Lead Source"; Rec."Honda Lead Source") { ApplicationArea = All; }
                field("Honda Preferred Dealer Code"; Rec."Honda Preferred Dealer Code") { ApplicationArea = All; }
                field("Honda Product Category"; Rec."Honda Product Category") { ApplicationArea = All; }
                field("Honda Preferred Model Code"; Rec."Honda Preferred Model Code") { ApplicationArea = All; }
                field("Honda Preferred Model Desc."; Rec."Honda Preferred Model Desc.") { ApplicationArea = All; }
                field("Honda Contact Preference"; Rec."Honda Contact Preference") { ApplicationArea = All; }
            }
            group(HondaAddressInformation)
            {
                Caption = 'Honda Address Information';
                field("Honda Province"; Rec."Honda Province") { ApplicationArea = All; }
                field("Honda District"; Rec."Honda District") { ApplicationArea = All; }
                field("Honda Municipality"; Rec."Honda Municipality") { ApplicationArea = All; }
                field("Honda Citizenship No."; Rec."Honda Citizenship No.") { ApplicationArea = All; }
            }
            group(HondaFollowup)
            {
                Caption = 'Honda Follow-up';
                field("Honda Last Attempted Date"; Rec."Honda Last Attempted Date") { ApplicationArea = All; Editable = false; }
                field("Honda Next Task Date"; Rec."Honda Next Task Date") { ApplicationArea = All; Editable = false; }
                field("Honda Consent to Contact"; Rec."Honda Consent to Contact") { ApplicationArea = All; }
                field("Honda Consent Date"; Rec."Honda Consent Date") { ApplicationArea = All; }
                field("Honda Do Not Contact"; Rec."Honda Do Not Contact") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            group(HondaCRMActions)
            {
                Caption = 'Honda CRM';
                action(CheckPossibleDuplicates)
                {
                    ApplicationArea = All;
                    Caption = 'Check Possible Duplicates';
                    Image = ContactReference;

                    trigger OnAction()
                    var
                        HondaCRMManagement: Codeunit "Honda CRM Management";
                    begin
                        HondaCRMManagement.CheckContactDuplicates(Rec, true);
                    end;
                }
                action(CreateHondaOpportunity)
                {
                    ApplicationArea = All;
                    Caption = 'Create Honda Opportunity';
                    Image = NewOpportunity;

                    trigger OnAction()
                    var
                        Opportunity: Record Opportunity;
                        HondaCRMManagement: Codeunit "Honda CRM Management";
                    begin
                        HondaCRMManagement.CreateOpportunityFromContact(Rec, Opportunity);
                    end;
                }
                action(HondaOpportunities)
                {
                    ApplicationArea = All;
                    Caption = 'Honda Opportunities';
                    Image = OpportunityList;
                    RunObject = page "Opportunity List";
                    RunPageLink = "Contact No." = field("No.");
                }
                action(CreateFollowup)
                {
                    ApplicationArea = All;
                    Caption = 'Create Follow-up';
                    Image = Task;

                    trigger OnAction()
                    var
                        HondaCRMManagement: Codeunit "Honda CRM Management";
                    begin
                        HondaCRMManagement.CreateContactActivity(Rec);
                    end;
                }
                action(HondaActivities)
                {
                    ApplicationArea = All;
                    Caption = 'Honda Activities';
                    Image = TaskList;
                    RunObject = page "Honda CRM Activity List";
                    RunPageLink = "Contact No." = field("No."), Status = const(Open);
                }
                action(HondaActivityHistory)
                {
                    ApplicationArea = All;
                    Caption = 'Honda Activity History';
                    Image = History;
                    RunObject = page "Honda CRM Activity List";
                    RunPageLink = "Contact No." = field("No."), Status = filter(Completed|Cancelled);
                }
            }
        }
    }
}
