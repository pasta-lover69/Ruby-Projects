require 'tk'

# Main Interface
root = TkRoot.new { title "Calculator" }

# Entry for input and output
entry = TkEntry.new(root) do
  width 30
  pack(padx: 10, pady: 10)
end

# Method to handle button press
def add_to_entry(entry, value)
  entry.insert('end', value)
end

def evaluate(entry)
  begin
    result = eval(entry.get)
    entry.delete(0, 'end')
    entry.insert(0, result.to_s)
  rescue
    entry.delete(0, 'end')
    entry.insert(0, "Error")
  end
end

def clear(entry)
  entry.delete(0, 'end')
end

def delete_last(entry)
  current_text = entry.get
  entry.delete(0, 'end')
  entry.insert(0, current_text[0...-1]) unless current_text.empty?
end

# Buttons
buttons = [
  ['7', '8', '9', '/'],
  ['4', '5', '6', '*'],
  ['1', '2', '3', '-'],
  ['0', '.', '=', '+']
]

buttons.each do |row_values|
  frame = TkFrame.new(root).pack
  row_values.each do |val|
    TkButton.new(frame) do
      text val
      width 5
      command do
        case val
        when '='
          evaluate(entry)
        else
          add_to_entry(entry, val)
        end
      end
      pack(side: 'left', padx: 2, pady: 2)
    end
  end
end

# Clear button
TkButton.new(root) do
  text "Clear"
  command { clear(entry) }
  pack(pady: 5)
end

# Backspace button
TkButton.new(root) do
  text "Backspace"
  command { delete_last(entry) }
  pack(pady: 5)
end

Tk.mainloop
