table 51005 "Honda Opp. Status Entry"
{
    DataClassification = SystemMetadata;
    Caption = 'Honda Opp. Status Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Opportunity No."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Opportunity No.';
            TableRelation = Opportunity."No.";
        }
        field(3; "Old CRM Stage"; Enum "Honda Opportunity CRM Stage")
        {
            DataClassification = SystemMetadata;
            Caption = 'Old CRM Stage';
        }
        field(4; "New CRM Stage"; Enum "Honda Opportunity CRM Stage")
        {
            DataClassification = SystemMetadata;
            Caption = 'New CRM Stage';
        }
        field(5; "Old Result"; Enum "Honda Opportunity Result")
        {
            DataClassification = SystemMetadata;
            Caption = 'Old Result';
        }
        field(6; "New Result"; Enum "Honda Opportunity Result")
        {
            DataClassification = SystemMetadata;
            Caption = 'New Result';
        }
        field(7; "Change Date-Time"; DateTime)
        {
            DataClassification = SystemMetadata;
            Caption = 'Change Date-Time';
        }
        field(8; "Changed By"; Code[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Changed By';
        }
        field(9; Reason; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Reason';
        }
        field(10; Comment; Text[250])
        {
            DataClassification = SystemMetadata;
            Caption = 'Comment';
        }
        field(11; "Sales Cycle Code"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Sales Cycle Code';
            TableRelation = "Sales Cycle".Code;
        }
        field(12; "Sales Cycle Stage"; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Sales Cycle Stage';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Opportunity No.", "Entry No.") {}
    }
}
