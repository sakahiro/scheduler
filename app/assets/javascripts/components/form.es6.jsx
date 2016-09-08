class Form extends React.Component {
  constructor() {
    super();

    this.state = {
      formCount: [1]
    };
  }

  render () {
    let formfield = this._getField()
    let n = this.state.formCount.length
    return (
      <div>
        <div onClick={this._handleClick.bind(this)} className="btn btn-default">フィールドを追加する</div>
        { formfield }
        <input name={this.props.prefix} type="hidden" value={ n } />
      </div>
    );
  }

  _handleClick() {
    let count = this.state.formCount[this.state.formCount.length-1] + 1
    let array = this.state.formCount.concat([count])
    this.setState ({
      formCount: array
    })
  }

  _getField() {
    return this.state.formCount.map((i) => {
      return < FormField prefix={this.props.prefix + i} />
    });
  }
}

class FormField extends React.Component {
  render () {
    return (
      <div className="form-group form-inline">
        <label htmlFor={this.props.prefix + "_title"}>項目</label>
        <input id={this.props.prefix + "_title"}
               name={this.props.prefix + "_title"}
               className="form-control"
               type="text" />

        <label htmlFor={this.props.prefix + "_progress"}>進捗</label>
        <select id={this.props.prefix + "_progress"}
                name={this.props.prefix + "_progress"}
                className="form-control">
          <option value="" >達成度</option>
          <option value={30} >30</option>
          <option value={50} >50</option>
          <option value={70} >70</option>
          <option value={100} >100</option>
        </select>

        <label htmlFor={this.props.prefix + "_day"}>終了予定日</label>
        <input id={this.props.prefix + "_day"}
               name={this.props.prefix + "_day"}
               className="form-control"
               type="date" />
      </div>
    )
  }
}


Form.propTypes = {
  title: React.PropTypes.string,
  progress: React.PropTypes.string,
  day: React.PropTypes.string
};
