table 51001 "Honda Vehicle Model"
{
    DataClassification = CustomerContent;
    Caption = 'Honda Vehicle Model';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';

            trigger OnValidate()
            begin
                if Description = '' then
                    Error('Description is mandatory.');
                UpdateLastDateModified();
            end;
        }
        field(3; "Product Category"; Enum "Honda Product Category")
        {
            DataClassification = CustomerContent;
            Caption = 'Product Category';

            trigger OnValidate()
            begin
                if "Product Category" = "Product Category"::" " then
                    Error('Product Category is mandatory.');
                UpdateLastDateModified();
            end;
        }
        field(4; "Make Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Make Code';
            InitValue = 'HONDA';

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(5; "Model Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Model Year';

            trigger OnValidate()
            begin
                if "Model Year" < 0 then
                    Error('Model Year cannot be negative.');
                UpdateLastDateModified();
            end;
        }
        field(6; "Starting Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Starting Price';

            trigger OnValidate()
            begin
                if "Starting Price" < 0 then
                    Error('Starting Price cannot be negative.');
                UpdateLastDateModified();
            end;
        }
        field(7; Active; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Active';
            InitValue = true;

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(8; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
            InitValue = false;

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(9; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(10; "Last Date Modified"; Date)
        {
            DataClassification = SystemMetadata;
            Caption = 'Last Date Modified';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    local procedure UpdateLastDateModified()
    begin
        "Last Date Modified" := Today;
    end;
}
