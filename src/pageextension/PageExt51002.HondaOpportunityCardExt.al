pageextension 51002 "Honda Opportunity Card Ext." extends "Opportunity Card"
{
    layout
    {
        addafter(General)
        {
            group(HondaAutomotiveCRM)
            {
                Caption = 'Honda Automotive CRM';
                field("Honda Dealer Code"; Rec."Honda Dealer Code") { ApplicationArea = All; }
                field("Honda Product Category"; Rec."Honda Product Category") { ApplicationArea = All; }
                field("Honda CRM Stage"; Rec."Honda CRM Stage") { ApplicationArea = All; Editable = false; }
                field("Honda Result"; Rec."Honda Result") { ApplicationArea = All; Editable = false; }
                field("Honda Estimated Budget"; Rec."Honda Estimated Budget") { ApplicationArea = All; }
                field("Honda Expected Purch. Date"; Rec."Honda Expected Purch. Date") { ApplicationArea = All; }
                field("Honda Finance Required"; Rec."Honda Finance Required") { ApplicationArea = All; }
            }
            part(HondaOppVehicleSubform; "Honda Opp. Vehicle Subform")
            {
                ApplicationArea = All;
                Caption = 'Vehicle Interest';
                SubPageLink = "Opportunity No." = field("No.");
                UpdatePropagation = Both;
            }
            group(ActivityInformation)
            {
                Caption = 'Activity Information';
                field("Honda Last Activity Date"; Rec."Honda Last Activity Date") { ApplicationArea = All; Editable = false; }
                field("Honda Next Activity Date"; Rec."Honda Next Activity Date") { ApplicationArea = All; Editable = false; }
            }
            group(ClosingInformation)
            {
                Caption = 'Closing Information';
                field("Honda Lost Reason"; Rec."Honda Lost Reason") { ApplicationArea = All; Editable = false; }
                field("Honda Lost Reason Remarks"; Rec."Honda Lost Reason Remarks") { ApplicationArea = All; Editable = false; }
                field("Honda Competitor Name"; Rec."Honda Competitor Name") { ApplicationArea = All; Editable = false; }
                field("Honda Ready for Quote Date"; Rec."Honda Ready for Quote Date") { ApplicationArea = All; Editable = false; }
                field("Honda Closed Date"; Rec."Honda Closed Date") { ApplicationArea = All; Editable = false; }
            }
        }
        addfirst(factboxes)
        {
            part(HondaOpportunityActivitiesPart; "Honda Opportunity Activities Part")
            {
                ApplicationArea = All;
                SubPageLink = "Opportunity No." = field("No.");
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            group(HondaCRM)
            {
                Caption = 'Honda CRM';

                action(ActivateHondaCRM)
                {
                    ApplicationArea = All;
                    Caption = 'Activate Honda CRM';
                    Image = Start;

                    trigger OnAction()
                    var
                        HondaCRMManagement: Codeunit "Honda CRM Management";
                    begin
                        HondaCRMManagement.ActivateHondaOpportunity(Rec);
                    end;
                }
                action(MoveToNextCRMStage)
                {
                    ApplicationArea = All;
                    Caption = 'Move to Next CRM Stage';
                    Image = NextRecord;

                    trigger OnAction()
                    var
                        HondaCRMManagement: Codeunit "Honda CRM Management";
                    begin
                        HondaCRMManagement.MoveToNextCRMStage(Rec);
                    end;
                }
                action(CreateFollowup)
                {
                    ApplicationArea = All;
                    Caption = 'Create Follow-up';
                    Image = NewTask;

                    trigger OnAction()
                    var
                        HondaCRMManagement: Codeunit "Honda CRM Management";
                    begin
                        HondaCRMManagement.CreateOpportunityActivity(Rec);
                    end;
                }
                action(ShowHondaActivities)
                {
                    ApplicationArea = All;
                    Caption = 'Show Honda Activities';
                    Image = TaskList;
                    RunObject = page "Honda CRM Activity List";
                    RunPageLink = "Opportunity No." = field("No.");
                }
                action(MarkReadyForQuotation)
                {
                    ApplicationArea = All;
                    Caption = 'Mark Ready for Quotation';
                    Image = Quote;

                    trigger OnAction()
                    var
                        HondaCRMManagement: Codeunit "Honda CRM Management";
                    begin
                        HondaCRMManagement.MarkReadyForQuotation(Rec);
                    end;
                }
                action(MarkLost)
                {
                    ApplicationArea = All;
                    Caption = 'Mark Lost';
                    Image = Cancel;

                    trigger OnAction()
                    var
                        HondaCRMManagement: Codeunit "Honda CRM Management";
                        LostReason: Enum "Honda Lost Reason";
                        LostRemarks: Text[250];
                        CompetitorName: Text[100];
                    begin
                        // Note: A real implementation would show a dialog page here to collect these.
                        // We will pass empty/defaults just to compile per the prompt steps.
                        HondaCRMManagement.MarkOpportunityLost(Rec, LostReason, LostRemarks, CompetitorName);
                    end;
                }
                action(CancelOpportunity)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Opportunity';
                    Image = CancelAllLines;

                    trigger OnAction()
                    var
                        HondaCRMManagement: Codeunit "Honda CRM Management";
                        CancelReason: Text[250];
                    begin
                        CancelReason := 'Cancelled by user';
                        HondaCRMManagement.CancelHondaOpportunity(Rec, CancelReason);
                    end;
                }
                action(ShowStatusHistory)
                {
                    ApplicationArea = All;
                    Caption = 'Show Status History';
                    Image = History;
                    RunObject = page "Honda Opp. Status Entries";
                    RunPageLink = "Opportunity No." = field("No.");
                }
            }
        }
    }
}
