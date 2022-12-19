class TeaSerializer
  def self.create_tea(new_tea)
    {
      data: {
        id: new_tea.id},
        type: "tea",
        attributes: {
          name: new_tea.name,
          description: new_tea.description,
          temp: new_tea.temp,
          brew_time: new_tea.brew_time
        }
      }
  end

  def self.get_teas(teas)
    {
      data: teas.map do |tea|{
        id: tea.id,
        type: "tea",
        attributes: {
          name: tea.name,
          description: tea.description,
          temp: tea.temp,
          brew_time: tea.brew_time
        }
      }
      end
    }
  end
end