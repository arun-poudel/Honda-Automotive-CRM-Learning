page 51007 "Honda CRM Activity Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Honda CRM Activity";
    Caption = 'Honda CRM Activity Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Contact No."; Rec."Contact No.") { ApplicationArea = All; }
                field("Activity Type"; Rec."Activity Type") { ApplicationArea = All; }
                field(Subject; Rec.Subject) { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; Editable = false; }
            }
            group(Schedule)
            {
                Caption = 'Schedule';
                field("Activity Date"; Rec."Activity Date") { ApplicationArea = All; }
                field("Due Date"; Rec."Due Date") { ApplicationArea = All; }
                field("Due Time"; Rec."Due Time") { ApplicationArea = All; }
            }
            group(RelatedRecords)
            {
                Caption = 'Related Records';
                field("Opportunity No."; Rec."Opportunity No.") { ApplicationArea = All; }
            }
            group(Assignment)
            {
                Caption = 'Assignment';
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Dealer Code"; Rec."Dealer Code") { ApplicationArea = All; }
            }
            group(Completion)
            {
                Caption = 'Completion';
                field(Outcome; Rec.Outcome) { ApplicationArea = All; }
                field("Completed Date-Time"; Rec."Completed Date-Time") { ApplicationArea = All; }
                field("Completed By"; Rec."Completed By") { ApplicationArea = All; }
            }
            group(Cancellation)
            {
                Caption = 'Cancellation';
                field("Cancellation Reason"; Rec."Cancellation Reason") { ApplicationArea = All; }
                field("Cancelled Date-Time"; Rec."Cancelled Date-Time") { ApplicationArea = All; }
                field("Cancelled By"; Rec."Cancelled By") { ApplicationArea = All; }
            }
            group(NotesGrp)
            {
                Caption = 'Notes';
                field(Notes; Rec.Notes) { ApplicationArea = All; MultiLine = true; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Complete)
            {
                ApplicationArea = All;
                Caption = 'Complete Activity';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    HondaCRMManagement: Codeunit "Honda CRM Management";
                begin
                    HondaCRMManagement.CompleteActivity(Rec);
                end;
            }
            action(CancelAct)
            {
                ApplicationArea = All;
                Caption = 'Cancel Activity';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    HondaCRMManagement: Codeunit "Honda CRM Management";
                begin
                    HondaCRMManagement.CancelActivity(Rec);
                end;
            }
        }
    }
}
