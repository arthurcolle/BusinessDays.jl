
"""
*Abstract* type for Holiday Calendars.
"""
@compat abstract type HolidayCalendar; end

Base.string(hc::HolidayCalendar) = string(typeof(hc))

function symtocalendar(sym::Symbol)
    local result::HolidayCalendar

    if isdefined(BusinessDays, sym) && eval(BusinessDays, sym) <: HolidayCalendar
        result = eval(BusinessDays, sym)()
    elseif isdefined(current_module(), sym) && eval(current_module(), sym) <: HolidayCalendar
        result = eval(current_module(), sym)()
    else
        error("$sym is not a valid HolidayCalendar.")
    end

    return result
end

@inline strtocalendar(str::AbstractString) = symtocalendar(Symbol(str))

Base.convert(::Type{HolidayCalendar}, sym::Symbol) = symtocalendar(sym)
Base.convert(::Type{HolidayCalendar}, str::AbstractString) = strtocalendar(str)

"""
    isholiday(calendar, dt)

Checks if `dt` is a holiday based on a given `calendar` of holidays.

`calendar` can be an instance of `HolidayCalendar`,  a `Symbol` or an `AbstractString`.

Returns boolean values.
"""
isholiday(hc::HolidayCalendar, dt::Date) = error("isholiday for $(hc) not implemented.")

isholiday(calendar, dt::Date) = isholiday(convert(HolidayCalendar, calendar), dt)
