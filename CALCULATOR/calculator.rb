require 'tk'

root = TkRoot.new { title "Calculator" }
root.configure('background' => '#f0f0f0')

entry = TkEntry.new(root) do
  width 30
  font TkFont.new('times 16 bold')
  justify 'right'
  pack(padx: 10, pady: 10)
end

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

buttons = [
  ['7', '8', '9', '/'],
  ['4', '5', '6', '*'],
  ['1', '2', '3', '-'],
  ['0', '.', '=', '+']
]

buttons.each do |row_values|
  frame = TkFrame.new(root) do
    pack(padx: 5, pady: 5)
  end
  row_values.each do |val|
    TkButton.new(frame) do
      text val
      width 5
      height 2
      font TkFont.new('times 14 bold')
      background '#d9d9d9'
      activebackground '#bfbfbf'
      command do
        case val
        when '='
          evaluate(entry)
        else
          add_to_entry(entry, val)
        end
      end
      pack(side: 'left', padx: 5, pady: 5)
    end
  end
end

TkButton.new(root) do
  text "Clear"
  font TkFont.new('times 14 bold')
  background '#ff6666'
  activebackground '#ff4d4d'
  command { clear(entry) }
  pack(pady: 5, padx: 10, side: 'left')
end

TkButton.new(root) do
  text "Backspace"
  font TkFont.new('times 14 bold')
  background '#ffcc66' # Light orange background
  activebackground '#ffb84d' # Darker orange when pressed
  command { delete_last(entry) }
  pack(pady: 5, padx: 10, side: 'right')
end

Tk.mainloop
