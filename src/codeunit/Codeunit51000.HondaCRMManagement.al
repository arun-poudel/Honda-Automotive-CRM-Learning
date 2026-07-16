codeunit 51000 "Honda CRM Management"
{
    procedure CheckContactDuplicates(Contact: Record Contact; ShowResults: Boolean): Boolean
    var
        DupContact: Record Contact;
        DuplicateFound: Boolean;
    begin
        DuplicateFound := false;

        if Contact."No." = '' then
            exit(false);

        // Check Phone No.
        if Contact."Phone No." <> '' then begin
            DupContact.Reset();
            DupContact.SetFilter("No.", '<>%1', Contact."No.");
            DupContact.SetRange("Phone No.", Contact."Phone No.");
            if not DupContact.IsEmpty() then begin
                DuplicateFound := true;
            end else begin
                // Check Mobile Phone No. as well if phone is populated in it
                if Contact."Mobile Phone No." <> '' then begin
                    DupContact.Reset();
                    DupContact.SetFilter("No.", '<>%1', Contact."No.");
                    DupContact.SetRange("Mobile Phone No.", Contact."Mobile Phone No.");
                    if not DupContact.IsEmpty() then
                        DuplicateFound := true;
                end;
            end;
        end;

        // Check E-Mail
        if (not DuplicateFound) and (Contact."E-Mail" <> '') then begin
            DupContact.Reset();
            DupContact.SetFilter("No.", '<>%1', Contact."No.");
            DupContact.SetRange("E-Mail", Contact."E-Mail");
            if not DupContact.IsEmpty() then
                DuplicateFound := true;
        end;

        if DuplicateFound then begin
            Message('Possible duplicate contacts found based on Phone No. or E-Mail.');
            if ShowResults then begin
                DupContact.Reset();
                DupContact.SetFilter("No.", '<>%1', Contact."No.");

                if (Contact."Phone No." <> '') then begin
                    DupContact.SetRange("Phone No.", Contact."Phone No.");
                    if DupContact.IsEmpty() then DupContact.SetRange("Phone No.");
                end;

                if (Contact."E-Mail" <> '') then begin
                    DupContact.SetRange("E-Mail", Contact."E-Mail");
                    if DupContact.IsEmpty() then DupContact.SetRange("E-Mail");
                end;

                Page.Run(Page::"Contact List", DupContact);
            end;
        end else begin
            if ShowResults then
                Message('No duplicates found.');
        end;

        exit(DuplicateFound);
    end;

    procedure CreateOpportunityFromContact(Contact: Record Contact; var Opportunity: Record Opportunity)
    var
        OppLine: Record "Honda Opp. Vehicle Line";
        Dealer: Record "Honda Dealer";
    begin
        Contact.TestField("No.");
        Contact.TestField(Name);
        if (Contact."Phone No." = '') and (Contact."E-Mail" = '') and (Contact."Mobile Phone No." = '') then
            Error('At least Phone No. or E-Mail must be provided.');

        CheckContactDuplicates(Contact, false);

        Contact.TestField("Salesperson Code");
        Contact.TestField("Honda Preferred Dealer Code");

        Dealer.Get(Contact."Honda Preferred Dealer Code");
        if not Dealer.Active then Error('Dealer must be active.');
        if Dealer.Blocked then Error('Dealer must not be blocked.');

        // Use standard Opportunity Management if possible, but for part 1 simplicity we can init manually
        // according to the steps:
        Opportunity.Init();
        Opportunity.Insert(true); // Generates No.
        Opportunity.Validate("Contact No.", Contact."No.");
        Opportunity.Validate("Salesperson Code", Contact."Salesperson Code");
        Opportunity."Honda Dealer Code" := Contact."Honda Preferred Dealer Code";
        Opportunity."Honda Product Category" := Contact."Honda Product Category";
        Opportunity."Honda CRM Stage" := Opportunity."Honda CRM Stage"::New;
        Opportunity."Honda Result" := Opportunity."Honda Result"::Open;

        Opportunity.Modify(true);

        if Contact."Honda Preferred Model Code" <> '' then begin
            OppLine.Init();
            OppLine."Opportunity No." := Opportunity."No.";
            OppLine."Line No." := 10000;
            OppLine.Validate("Model Code", Contact."Honda Preferred Model Code");
            OppLine.Validate("Primary Interest", true);
            OppLine.Insert(true);
        end;

        InsertStatusHistory(Opportunity, Opportunity."Honda CRM Stage"::New, Opportunity."Honda CRM Stage"::New, Opportunity."Honda Result"::Open, Opportunity."Honda Result"::Open, 'Opportunity Created');

        OnAfterHondaOpportunityCreated(Contact, Opportunity);

        Page.Run(Page::"Opportunity Card", Opportunity);
    end;

    procedure ActivateHondaOpportunity(var Opportunity: Record Opportunity)
    var
        OppLine: Record "Honda Opp. Vehicle Line";
    begin
        Opportunity.TestField("Honda Result", Opportunity."Honda Result"::Open);
        Opportunity.TestField("Contact No.");
        Opportunity.TestField("Salesperson Code");
        Opportunity.TestField("Honda Dealer Code");
        Opportunity.TestField("Sales Cycle Code");

        OppLine.SetRange("Opportunity No.", Opportunity."No.");
        if OppLine.IsEmpty() then
            Error('At least one vehicle-interest line must exist.');

        OppLine.SetRange("Primary Interest", true);
        if OppLine.Count() <> 1 then
            Error('Exactly one line should be the Primary Interest.');

        if Opportunity."Honda Estimated Budget" < 0 then
            Error('Estimated Budget cannot be negative.');

        Opportunity.TestField("Honda Expected Purch. Date");

        // Standard Activate logic (simulated for Part 1)
        Opportunity.Status := Opportunity.Status::"In Progress";

        // Custom logic
        Opportunity."Honda CRM Stage" := Opportunity."Honda CRM Stage"::"Initial Contact";
        Opportunity."Honda Result" := Opportunity."Honda Result"::Open;
        Opportunity.Modify(true);

        InsertStatusHistory(Opportunity, Opportunity."Honda CRM Stage"::New, Opportunity."Honda CRM Stage"::"Initial Contact", Opportunity."Honda Result"::Open, Opportunity."Honda Result"::Open, 'Opportunity Activated');

        CreateInitialFollowUp(Opportunity);

        OnAfterHondaOpportunityActivated(Opportunity);

        Message('Opportunity activated successfully.');
    end;

    procedure MoveToNextCRMStage(var Opportunity: Record Opportunity)
    var
        OldStage: Enum "Honda Opportunity CRM Stage";
        NewStage: Enum "Honda Opportunity CRM Stage";
        Activity: Record "Honda CRM Activity";
        OppLine: Record "Honda Opp. Vehicle Line";
    begin
        Opportunity.TestField("Honda Result", Opportunity."Honda Result"::Open);

        OldStage := Opportunity."Honda CRM Stage";

        case OldStage of
            OldStage::New:
                Error('Use Activate Honda CRM instead.');
            OldStage::"Initial Contact":
                begin
                    // Require completed Phone Call, Meeting, or Showroom Visit
                    Activity.SetRange("Opportunity No.", Opportunity."No.");
                    Activity.SetRange(Status, Activity.Status::Completed);
                    Activity.SetFilter("Activity Type", '%1|%2|%3', Activity."Activity Type"::"Phone Call", Activity."Activity Type"::Meeting, Activity."Activity Type"::"Showroom Visit");
                    if Activity.IsEmpty() then
                        Error('A completed Phone Call, Meeting, or Showroom Visit is required to move to Needs Analysis.');

                    Opportunity.TestField("Honda Estimated Budget");
                    Opportunity.TestField("Honda Expected Purch. Date");

                    NewStage := NewStage::"Needs Analysis";
                end;
            OldStage::"Needs Analysis":
                begin
                    OppLine.SetRange("Opportunity No.", Opportunity."No.");
                    if OppLine.IsEmpty() then
                        Error('At least one vehicle-interest line is required.');
                    OppLine.SetRange("Primary Interest", true);
                    if OppLine.IsEmpty() then
                        Error('One Primary Interest line is required.');

                    NewStage := NewStage::"Vehicle Selection";
                end;
            OldStage::"Vehicle Selection":
                begin
                    Opportunity.TestField("Honda Primary Model Code");
                    Activity.SetRange("Opportunity No.", Opportunity."No.");
                    Activity.SetFilter(Status, '%1|%2', Activity.Status::Completed, Activity.Status::Open);
                    Activity.SetRange("Activity Type", Activity."Activity Type"::"Test Drive Request");
                    if Activity.IsEmpty() then
                        Error('An open or completed Test Drive Request activity is required to move to Test Drive.');

                    NewStage := NewStage::"Test Drive";
                end;
            OldStage::"Test Drive":
                begin
                    Activity.SetRange("Opportunity No.", Opportunity."No.");
                    Activity.SetRange(Status, Activity.Status::Completed);
                    Activity.SetRange("Activity Type", Activity."Activity Type"::"Test Drive Request");
                    if Activity.IsEmpty() then
                        Error('A completed Test Drive Request activity is required to move to Quotation Ready.');

                    NewStage := NewStage::"Quotation Ready";
                end;
            OldStage::"Quotation Ready":
                Error('Opportunity is already at Quotation Ready.');
        end;

        Opportunity."Honda CRM Stage" := NewStage;
        Opportunity.Modify(true);

        InsertStatusHistory(Opportunity, OldStage, NewStage, Opportunity."Honda Result", Opportunity."Honda Result", 'Moved to next CRM stage');

        OnAfterHondaCRMStageChanged(Opportunity, OldStage, NewStage);
    end;

    procedure MarkReadyForQuotation(var Opportunity: Record Opportunity)
    var
        Activity: Record "Honda CRM Activity";
    begin
        Opportunity.TestField("Honda Result", Opportunity."Honda Result"::Open);
        Opportunity.TestField("Honda CRM Stage", Opportunity."Honda CRM Stage"::"Quotation Ready");
        Opportunity.TestField("Contact No.");
        Opportunity.TestField("Honda Dealer Code");
        Opportunity.TestField("Salesperson Code");
        Opportunity.TestField("Honda Primary Model Code");
        if Opportunity."Honda Estimated Budget" <= 0 then
            Error('Estimated Budget must be greater than zero.');
        Opportunity.TestField("Honda Expected Purch. Date");
        if Opportunity."Honda Lost Reason" <> Opportunity."Honda Lost Reason"::Price then // using Price as placeholder for blank/empty
            if format(Opportunity."Honda Lost Reason") <> '' then
                Error('Lost Reason must be blank.'); // Technically enum always has a value, but assume it should be default

        // Check overdue activities
        Activity.SetRange("Opportunity No.", Opportunity."No.");
        Activity.SetRange(Status, Activity.Status::Open);
        Activity.SetFilter("Due Date", '<%1', WorkDate());
        if not Activity.IsEmpty() then
            Error('No overdue mandatory activity can remain open.');

        Opportunity."Honda Result" := Opportunity."Honda Result"::"Ready for Quotation";
        Opportunity."Honda Ready for Quote Date" := WorkDate();
        Opportunity.Modify(true);

        InsertStatusHistory(Opportunity, Opportunity."Honda CRM Stage", Opportunity."Honda CRM Stage", Opportunity."Honda Result"::Open, Opportunity."Honda Result"::"Ready for Quotation", 'Marked Ready for Quotation');

        OnAfterHondaOpportunityReadyForQuotation(Opportunity);
    end;

    procedure MarkOpportunityLost(var Opportunity: Record Opportunity; LostReason: Enum "Honda Lost Reason"; LostRemarks: Text[250]; CompetitorName: Text[100])
    var
        Activity: Record "Honda CRM Activity";
    begin
        if (Opportunity."Honda Result" = Opportunity."Honda Result"::Lost) or (Opportunity."Honda Result" = Opportunity."Honda Result"::Cancelled) then
            Error('An already lost or cancelled opportunity cannot be lost again.');

        // Require reasons
        if format(LostReason) = '' then Error('Lost Reason is mandatory.');
        if (LostReason = LostReason::Other) and (LostRemarks = '') then
            Error('Remarks are mandatory when Lost Reason is Other.');
        if (LostReason = LostReason::Competitor) and (CompetitorName = '') then
            Error('Competitor Name is mandatory when reason is Competitor.');

        Opportunity."Honda Lost Reason" := LostReason;
        Opportunity."Honda Lost Reason Remarks" := LostRemarks;
        Opportunity."Honda Competitor Name" := CompetitorName;
        Opportunity."Honda Closed Date" := WorkDate();
        Opportunity."Honda Result" := Opportunity."Honda Result"::Lost;
        Opportunity.Status := Opportunity.Status::Lost;
        Opportunity.Modify(true);

        // Cancel Open activities
        Activity.SetRange("Opportunity No.", Opportunity."No.");
        Activity.SetRange(Status, Activity.Status::Open);
        if Activity.FindSet() then begin
            repeat
                Activity."Cancellation Reason" := 'System: Opportunity Lost';
                CancelActivity(Activity);
            until Activity.Next() = 0;
        end;

        InsertStatusHistory(Opportunity, Opportunity."Honda CRM Stage", Opportunity."Honda CRM Stage", Opportunity."Honda Result"::Open, Opportunity."Honda Result"::Lost, 'Opportunity marked as Lost');
    end;

    procedure CancelHondaOpportunity(var Opportunity: Record Opportunity; Reason: Text[250])
    var
        Activity: Record "Honda CRM Activity";
    begin
        if Reason = '' then Error('Cancellation reason is mandatory.');
        if (Opportunity."Honda Result" = Opportunity."Honda Result"::"Ready for Quotation") or (Opportunity."Honda Result" = Opportunity."Honda Result"::Won) then
            Error('Ready-for-quotation or completed Opportunities should not be cancelled.');

        Opportunity."Honda Closed Date" := WorkDate();
        Opportunity."Honda Result" := Opportunity."Honda Result"::Cancelled;
        Opportunity.Modify(true);

        // Cancel open activities
        Activity.SetRange("Opportunity No.", Opportunity."No.");
        Activity.SetRange(Status, Activity.Status::Open);
        if Activity.FindSet() then begin
            repeat
                Activity."Cancellation Reason" := 'System: Opportunity Cancelled';
                CancelActivity(Activity);
            until Activity.Next() = 0;
        end;

        InsertStatusHistory(Opportunity, Opportunity."Honda CRM Stage", Opportunity."Honda CRM Stage", Opportunity."Honda Result"::Open, Opportunity."Honda Result"::Cancelled, Reason);
    end;

    // Activity Procedures
    procedure CreateContactActivity(Contact: Record Contact)
    var
        Activity: Record "Honda CRM Activity";
    begin
        Contact.TestField("Honda Do Not Contact", false);

        Activity.Init();
        Activity."Contact No." := Contact."No.";
        Activity."Salesperson Code" := Contact."Salesperson Code";
        Activity."Dealer Code" := Contact."Honda Preferred Dealer Code";
        Activity."Activity Type" := Activity."Activity Type"::"Follow Up";
        Activity.Subject := 'Follow Up';
        Activity.Insert(true);

        Page.Run(Page::"Honda CRM Activity Card", Activity);
    end;

    procedure CreateOpportunityActivity(Opportunity: Record Opportunity)
    var
        Activity: Record "Honda CRM Activity";
        Contact: Record Contact;
    begin
        if Contact.Get(Opportunity."Contact No.") then
            Contact.TestField("Honda Do Not Contact", false);

        Activity.Init();
        Activity."Contact No." := Opportunity."Contact No.";
        Activity."Opportunity No." := Opportunity."No.";
        Activity."Salesperson Code" := Opportunity."Salesperson Code";
        Activity."Dealer Code" := Opportunity."Honda Dealer Code";
        Activity."Activity Type" := Activity."Activity Type"::"Follow Up";
        Activity.Subject := 'Follow Up';
        Activity.Insert(true);

        Page.Run(Page::"Honda CRM Activity Card", Activity);
    end;

    local procedure CreateInitialFollowUp(Opportunity: Record Opportunity)
    var
        Activity: Record "Honda CRM Activity";
    begin
        Activity.Init();
        Activity."Contact No." := Opportunity."Contact No.";
        Activity."Opportunity No." := Opportunity."No.";
        Activity."Salesperson Code" := Opportunity."Salesperson Code";
        Activity."Dealer Code" := Opportunity."Honda Dealer Code";
        Activity."Activity Type" := Activity."Activity Type"::"Follow Up";
        Activity.Subject := 'Initial Follow Up';
        Activity."Activity Date" := WorkDate();
        Activity."Due Date" := WorkDate() + 2;
        Activity.Insert(true);
    end;

    procedure CompleteActivity(var Activity: Record "Honda CRM Activity")
    var
        Contact: Record Contact;
        Opportunity: Record Opportunity;
    begin
        Activity.TestField(Status, Activity.Status::Open);
        Activity.TestField(Outcome);

        Activity.Status := Activity.Status::Completed;
        Activity."Completed Date-Time" := CurrentDateTime();
        Activity."Completed By" := UserId();
        Activity.Modify(true);

        if Contact.Get(Activity."Contact No.") then begin
            Contact."Last Date Attempted" := WorkDate();
            Contact."Honda Last Attempted Date" := WorkDate();
            Contact.Modify(false);
            UpdateContactNextTaskDate(Contact."No.");
        end;

        if Activity."Opportunity No." <> '' then begin
            if Opportunity.Get(Activity."Opportunity No.") then begin
                Opportunity."Honda Last Activity Date" := WorkDate();
                Opportunity.Modify(false);
                UpdateOpportunityActivityDates(Opportunity."No.");
            end;
        end;

        OnAfterHondaActivityCompleted(Activity);
    end;

    procedure CancelActivity(var Activity: Record "Honda CRM Activity")
    begin
        Activity.TestField(Status, Activity.Status::Open);
        Activity.TestField("Cancellation Reason");

        Activity.Status := Activity.Status::Cancelled;
        Activity."Cancelled Date-Time" := CurrentDateTime();
        Activity."Cancelled By" := UserId();
        Activity.Modify(true);
    end;

    procedure UpdateContactNextTaskDate(ContactNo: Code[20])
    var
        Activity: Record "Honda CRM Activity";
        Contact: Record Contact;
    begin
        Activity.SetCurrentKey("Contact No.", Status, "Due Date");
        Activity.SetRange("Contact No.", ContactNo);
        Activity.SetRange(Status, Activity.Status::Open);

        if Contact.Get(ContactNo) then begin
            if Activity.FindFirst() then
                Contact."Honda Next Task Date" := Activity."Due Date"
            else
                Contact."Honda Next Task Date" := 0D;
            Contact.Modify(false);
        end;
    end;

    procedure UpdateOpportunityActivityDates(OpportunityNo: Code[20])
    var
        Activity: Record "Honda CRM Activity";
        Opportunity: Record Opportunity;
    begin
        Activity.SetCurrentKey("Opportunity No.", Status, "Due Date");
        Activity.SetRange("Opportunity No.", OpportunityNo);
        Activity.SetRange(Status, Activity.Status::Open);

        if Opportunity.Get(OpportunityNo) then begin
            if Activity.FindFirst() then
                Opportunity."Honda Next Activity Date" := Activity."Due Date"
            else
                Opportunity."Honda Next Activity Date" := 0D;
            Opportunity.Modify(false);
        end;
    end;

    local procedure InsertStatusHistory(Opportunity: Record Opportunity; OldStage: Enum "Honda Opportunity CRM Stage"; NewStage: Enum "Honda Opportunity CRM Stage"; OldResult: Enum "Honda Opportunity Result"; NewResult: Enum "Honda Opportunity Result"; Reason: Text[100])
    var
        StatusEntry: Record "Honda Opp. Status Entry";
    begin
        StatusEntry.Init();
        StatusEntry."Opportunity No." := Opportunity."No.";
        StatusEntry."Old CRM Stage" := OldStage;
        StatusEntry."New CRM Stage" := NewStage;
        StatusEntry."Old Result" := OldResult;
        StatusEntry."New Result" := NewResult;
        StatusEntry."Change Date-Time" := CurrentDateTime();
        StatusEntry."Changed By" := UserId();
        StatusEntry.Reason := Reason;
        StatusEntry."Sales Cycle Code" := Opportunity."Sales Cycle Code";
        // StatusEntry."Sales Cycle Stage" := Opportunity."Sales Cycle Stage"; // Field is code in base standard, skipping for part 1 simplicity
        StatusEntry.Insert(true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterHondaOpportunityCreated(Contact: Record Contact; var Opportunity: Record Opportunity)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterHondaOpportunityActivated(var Opportunity: Record Opportunity)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterHondaCRMStageChanged(var Opportunity: Record Opportunity; OldStage: Enum "Honda Opportunity CRM Stage"; NewStage: Enum "Honda Opportunity CRM Stage")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterHondaActivityCompleted(var Activity: Record "Honda CRM Activity")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterHondaOpportunityReadyForQuotation(var Opportunity: Record Opportunity)
    begin
    end;
}
