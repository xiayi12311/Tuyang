local HStringRule = {}


function HStringRule:InitRule()
end
function HStringRule:SplitIntoMultipleStringsBasedOnTheDelimiter(InString)
    local tData = {}
    if not InString or InString == "" then
        return tData
    end
    
    -- 使用gmatch进行模式匹配，[^|]+ 表示匹配非分隔符的连续字符
    for match in string.gmatch(InString, "([^|]+)") do
        table.insert(tData, match)
    end
    
    return tData
end
function HStringRule:SplitIntoMultipleLinesBasedOnTheDelimiter(InString)
    local tData = {}
    if not InString or InString == "" then
        return ""
    end
    
    -- 匹配非连字符的连续字符
    for match in string.gmatch(InString, "([^-]+)") do
        table.insert(tData, "-"..match)
    end
    
    -- 用换行符连接结果
    return table.concat(tData, "\n")
end

-- 根据规则标注相关字体（只能用于RichText)

-- 规则表
--<font src="/Engine/EngineFonts/Roboto.Roboto" size="16" color="FFEA42FF" use_shadow="1" shadow_color="000000FF" shadow_offset="3;3">
HStringRule.LabelRule = {
    ["<abc>"] = '<font src="/Engine/EngineFonts/Roboto.Roboto" size="16" color="FFEA42FF" use_shadow="1" shadow_color="000000FF" shadow_offset="3;3">',
}



function HStringRule:LabelRelevantFontsAccordingToTheRules(InString)
    -- 先处理标签替换
    InString = InString:gsub("%<abc%>", HStringRule.LabelRule["<abc>"])
    return InString
end


HStringRule.InitRule()
return HStringRule