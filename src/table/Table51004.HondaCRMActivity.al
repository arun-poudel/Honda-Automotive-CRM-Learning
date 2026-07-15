table 51004 "Honda CRM Activity"
{
    DataClassification = CustomerContent;
    Caption = 'Honda CRM Activity';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Contact No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact No.';
            TableRelation = Contact."No.";

            trigger OnValidate()
            begin
                if "Contact No." = '' then
                    Error('Contact No. is mandatory.');
            end;
        }
        field(3; "Opportunity No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Opportunity No.';
            TableRelation = Opportunity."No.";
        }
        field(4; "Activity Type"; Enum "Honda CRM Activity Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Activity Type';
        }
        field(5; Subject; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject';

            trigger OnValidate()
            begin
                if Subject = '' then
                    Error('Subject is mandatory.');
            end;
        }
        field(6; "Activity Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Activity Date';
        }
        field(7; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';

            trigger OnValidate()
            begin
                if "Due Date" < "Activity Date" then
                    Error('Due Date cannot be before Activity Date.');
            end;
        }
        field(8; "Due Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Time';
        }
        field(9; Status; Enum "Honda CRM Activity Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(10; "Salesperson Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(11; "Dealer Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dealer Code';
            TableRelation = "Honda Dealer".Code;
        }
        field(12; Notes; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Notes';
        }
        field(13; Outcome; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Outcome';
        }
        field(14; "Created Date-Time"; DateTime)
        {
            DataClassification = SystemMetadata;
            Caption = 'Created Date-Time';
            Editable = false;
        }
        field(15; "Created By"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Created By';
            Editable = false;
        }
        field(16; "Completed Date-Time"; DateTime)
        {
            DataClassification = SystemMetadata;
            Caption = 'Completed Date-Time';
            Editable = false;
        }
        field(17; "Completed By"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Completed By';
            Editable = false;
        }
        field(18; "Cancelled Date-Time"; DateTime)
        {
            DataClassification = SystemMetadata;
            Caption = 'Cancelled Date-Time';
            Editable = false;
        }
        field(19; "Cancelled By"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Cancelled By';
            Editable = false;
        }
        field(20; "Cancellation Reason"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Reason';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Contact No.", Status, "Due Date") {}
        key(Key3; "Opportunity No.", Status, "Due Date") {}
        key(Key4; "Salesperson Code", Status, "Due Date") {}
        key(Key5; "Dealer Code", Status, "Due Date") {}
    }

    trigger OnInsert()
    begin
        "Created Date-Time" := CurrentDateTime();
        "Created By" := UserId();
        "Status" := "Status"::Open;
        if "Activity Date" = 0D then
            "Activity Date" := WorkDate();
        if "Due Date" = 0D then
            "Due Date" := WorkDate();
    end;

    trigger OnModify()
    begin
        if (xRec.Status = Status::Completed) or (xRec.Status = Status::Cancelled) then
            Error('Cannot modify a historical activity.');
    end;

    trigger OnDelete()
    begin
        if (Status = Status::Completed) or (Status = Status::Cancelled) then
            Error('Cannot delete a historical activity.');
    end;
}
