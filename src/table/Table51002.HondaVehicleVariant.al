table 51002 "Honda Vehicle Variant"
{
    DataClassification = CustomerContent;
    Caption = 'Honda Vehicle Variant';

    fields
    {
        field(1; "Model Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Model Code';
            TableRelation = "Honda Vehicle Model".Code;

            trigger OnValidate()
            begin
                if "Model Code" = '' then
                    Error('Model Code is mandatory.');
            end;
        }
        field(2; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(3; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';

            trigger OnValidate()
            begin
                if Description = '' then
                    Error('Description is mandatory.');
            end;
        }
        field(4; "Model Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Model Year';

            trigger OnValidate()
            begin
                if "Model Year" < 0 then
                    Error('Model Year cannot be negative.');
            end;
        }
        field(5; "Fuel Type"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fuel Type';
        }
        field(6; "Transmission Type"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Transmission Type';
        }
        field(7; "Color Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Color Description';
        }
        field(8; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                if "Unit Price" < 0 then
                    Error('Unit Price cannot be negative.');
            end;
        }
        field(9; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            TableRelation = Item."No.";
        }
        field(10; Active; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Active';
            InitValue = true;
        }
        field(11; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
            InitValue = false;
        }
    }

    keys
    {
        key(PK; "Model Code", Code)
        {
            Clustered = true;
        }
    }
}
