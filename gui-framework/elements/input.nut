enum Input
{
    Text,
    Password,
    Numbers
}

addEvent("GUI.onInputInsertLetter")
addEvent("GUI.onInputRemoveLetter")

class GUI.Input extends GUI.Texture
{

#private:
    m_type = null
    m_align = null
    m_placeholder = ""
    m_margin = 2
    m_text = ""
    m_active = false
    m_isDotPresent = false
    m_isScientificEPresent = false
#public:
    draw = null
    distance = null
    selector = "|"
    maxLetters = 1000

    constructor(x, y, w, h, file, font, type, align = Align.Left, placeholder = "", margin = 2, window = null)
    {
		draw = GUI.Draw(x, y, placeholder)
		draw.setDisabled(true)
        draw.setFont(font)

        m_placeholder = placeholder
        m_align = align
        m_type = type
        m_margin = margin
        m_text = ""
        m_active = false

		base.constructor(x, y, w, h, file, window)
		draw.top()

        alignText()
    }

    function alignText()
    {
        local pos = base.getPositionPx()
        local size = base.getSizePx()
        local sizeDraw = draw.getSizePx()
        switch(m_align)
        {
            case Align.Left:
                draw.setPositionPx(pos.x + m_margin, pos.y + size.height/2 - sizeDraw.height/2)
                break
            case Align.Center:
                draw.setPositionPx(pos.x + size.width/2 - sizeDraw.width/2, pos.y + size.height/2 - sizeDraw.height/2)
                break
            case Align.Right:
                draw.setPositionPx(pos.x + size.width - (sizeDraw.width + m_margin), pos.y + size.height/2 - sizeDraw.height/2)
                break
        }
    }

    function setVisible(bool)
    {
        base.setVisible(bool)
        draw.setVisible(bool)
    }

    function destroy()
	{
		base.destroy()
		draw.destroy()
	}

    function setPosition(x, y)
    {
        setPositionPx(nax(x), nay(y))
    }

    function setPositionPx(x, y)
    {
        base.setPositionPx(x, y)
        alignText()
    }

    function setAlpha(alpha)
    {
        draw.setAlpha(alpha)
        base.setAlpha(alpha)
    }

    function setText(text)
    {
        m_text = text

        if(!m_active && m_text == "")
        {
            draw.setText(m_placeholder)
            alignText()
            return
        }

        if(m_type == Input.Numbers)
        {
            m_isDotPresent = text.find(".") != null
            m_isScientificEPresent = text.find("e") != null || text.find("E") != null
        }

        if(m_active)
        {
            if(m_type == Input.Password)
                draw.setText(cutText(hash(m_text) + selector))
            else
                draw.setText(cutText(m_text + selector))
        }
        else
        {
            if(m_type == Input.Password)
                draw.setText(cutText(hash(m_text)))
            else
                draw.setText(cutText(m_text))
        }

        alignText()
    }

    function getText()
    {
        return m_text
    }

    function setPlaceHolder(holder)
    {
        if(!m_active && m_text == "")
        {
            draw.setText(holder)
            alignText()
        }

        m_placeholder = holder

    }

    function getPlaceHolder()
    {
        return m_placeholder
    }

    function setDisabled(disable)
    {
        base.setDisabled(disable)

        if(disable && m_active)
            setActive(false)
    }

    function setActive(status)
    {
        if(m_active == status)
            return

        enableKeys(!status)
        m_active = status
        setText(m_text)
    }

    static function cutText(text)
    {
        local size = base.getSizePx()
        local finishText = ""

        local oldFont = textGetFont()
		textSetFont(draw.getFont())

        for (local i = text.len(); i > 0; i--)
        {
            local char = text.slice(i-1, i);
            if(textWidthPx(finishText + char) < size.width - (2*m_margin))
                finishText = char + finishText
            else
            {
                textSetFont(oldFont)
                return finishText
            }
        }

        textSetFont(oldFont)
        return finishText
    }

    static function hash(text)
    {
        local endText = ""
        for(local i = 0; i < text.len(); i++)
            endText += "#"

        return endText
    }

    function removeLetter()
    {
        if(m_text.len() < 1)
            return

        setText(m_text.slice(0, m_text.len()-1))

        if(!base.getDisabled())
            callEvent("GUI.onInputRemoveLetter", this, m_text)
    }

    function addLetter(key)
    {
        if(m_text.len() > maxLetters)
            return

        local letter = getKeyLetter(key)

        if(!letter)
            return

        if(m_type == Input.Numbers)
        {
            if((m_text.len() == 0 && (letter == "-" || letter == "+"))
            || (!m_isDotPresent && (letter == "."))
            || (!m_isScientificEPresent && (letter == "e" || letter == "E"))
            || letter == "0" || letter == "1" || letter == "2" || letter == "3" || letter == "4"
            || letter == "5" || letter == "6" || letter == "7" || letter == "8" || letter == "9" || letter == "0")
                m_text += letter
        }
        else
            m_text += letter

        setText(m_text)

        if(!base.getDisabled())
            callEvent("GUI.onInputInsertLetter", this, letter)
    }

    static function onKey(key)
    {
        local focusedElement = GUI.Base.getFocusedElement()
        if (!(focusedElement instanceof this))
            return

        if(!focusedElement.m_active)
            return
            
        if(key == KEY_BACK)
            focusedElement.removeLetter()

        else
            focusedElement.addLetter(key)
    }

    static function onTakeFocus(self)
    {
        if (!(self instanceof this))
            return

        if(self.getDisabled())
            return

        self.setActive(true)
    }

    static function onLostFocus(self)
    {
        if (!(self instanceof this))
            return

        self.setActive(false)
    }
}

addEventHandler("onKey", GUI.Input.onKey.bindenv(GUI.Input))
addEventHandler("GUI.onTakeFocus", GUI.Input.onTakeFocus.bindenv(GUI.Input))
addEventHandler("GUI.onLostFocus", GUI.Input.onLostFocus.bindenv(GUI.Input))
