table 51000 "Honda Dealer"
{
    DataClassification = CustomerContent;
    Caption = 'Honda Dealer';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';

            trigger OnValidate()
            begin
                if Name = '' then
                    Error('Name must not be blank.');
                UpdateLastDateModified();
            end;
        }
        field(3; "Dealer Type"; Enum "Honda Dealer Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Dealer Type';

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(4; Address; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(5; "Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(6; City; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'City';

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(7; Province; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Province';

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(8; District; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'District';

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(9; Municipality; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality';

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(10; "Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(11; Email; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if Email <> '' then
                    MailManagement.CheckValidEmailAddress(Email);
                UpdateLastDateModified();
            end;
        }
        field(12; "Contact Person"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Person';

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(13; "Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(14; "Salesperson Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser".Code;

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(15; Active; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Active';
            InitValue = true;

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(16; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
            InitValue = false;

            trigger OnValidate()
            begin
                UpdateLastDateModified();
            end;
        }
        field(17; "Last Date Modified"; Date)
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
