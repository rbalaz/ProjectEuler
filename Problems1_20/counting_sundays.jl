# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
using Dates
sundays = 0
for i=1901:2000
    for j=1:12
        if dayofweek(Dates.DateTime(i, j, 1)) == 7
            global sundays += 1
        end
    end
end

println(string(sundays) * " Sundays fell on the first of the month during the twentieth century.")